//
//  RecipesViewController.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 24/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GetRecipesDelegate {

    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var connectionManager = ConnectionManager()
    var data:[Recipe] = []
    var ing:String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        connectionManager.delegate = self
        connectionManager.fetchData(ing: ing)
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
//        print(imageURL)
        cell.imageViewOutlet.setImageFromUrl(ImageURL: imageURL)
        
//        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: cell.frame.width - 10, height: cell.frame.height - 10))
//        let image = UIImage(named: "cellBackground")
//        imageView.image = image
//        cell.backgroundView = UIView()
//        cell.backgroundView!.addSubview(imageView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailVC") as! DetailsViewController
        
        detailVC.url = data[indexPath.row].href
        self.show(detailVC, sender: self)
     
    }


    func didGetRecipes(recipes: [Recipe]) {
        data = recipes
        DispatchQueue.main.async {
             self.tableViewOutlet.reloadData()
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
