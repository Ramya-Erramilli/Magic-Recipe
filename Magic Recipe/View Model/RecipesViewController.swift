//
//  RecipesViewController.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 24/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GetRecipesDelegate,ErrorReceived {
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var connectionManager = ConnectionManager()
    var data:[Recipe] = []
    var ing:String = ""
    var page = 1   
    var errorReceived:Error?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        connectionManager.delegate = self
        connectionManager.errorDelegate = self
        connectionManager.fetchData(ing: ing,page: page)
        
        if ing=="" {
            DispatchQueue.main.async {
                let alert = CustomAlert.createAlert(title: "No ingredient entered", descr: "Getting all available recipes...")
                self.present(alert, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let currentRecipe = data[indexPath.row]
        cell.name.text = currentRecipe.title
        let imgNum = Array(currentRecipe.thumbnail)[currentRecipe.thumbnail.count-5]
        let imageURL = "http://img.recipepuppy.com/\(imgNum).jpg"
        cell.imageViewOutlet.setImageFromUrl(ImageURL: imageURL)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: cell.frame.width - 10, height: cell.frame.height - 10))
        let image = UIImage(named: "cellBackground")
        imageView.image = image
        cell.backgroundView = UIView()
        cell.backgroundView!.addSubview(imageView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailVC") as! DetailsViewController
        detailVC.url = data[indexPath.row].href
        detailVC.titleName = data[indexPath.row].title
        self.show(detailVC, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == data.count-1{
            page += 1
            connectionManager.fetchData(ing: ing, page: page)
        }
    }
    
    func didGetRecipes(recipes: [Recipe]) {
        data += recipes
        DispatchQueue.main.async {
            self.tableViewOutlet.reloadData()            
        }
    }
    
    func errorReceived(error: Error) {
        DispatchQueue.main.async {
            self.showAlert(error)
        }
    }
    
    func showAlert(_ error:Error){
        let alert = CustomAlert.createAlert(title: "Error", descr: error.localizedDescription)
        self.present(alert, animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UIImageView{
    func setImageFromUrl(ImageURL :String) {
        URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            
            if let err = error{
                print(err.localizedDescription)
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
