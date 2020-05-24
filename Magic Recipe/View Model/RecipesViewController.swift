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
    var descrURL:String = ""
    
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
        print(imageURL)
        cell.imageViewOutlet.setImageFromUrl(ImageURL: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        descrURL = data[indexPath.row].href
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest =  segue.destination as! DetailsViewController
        dest.url = descrURL
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
