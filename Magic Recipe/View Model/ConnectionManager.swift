//
//  ConnectionManager.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//



//Pagination
//Custom alerts
//unit and ui test cases
//documentation


import Foundation
protocol GetRecipesDelegate {
    func didGetRecipes(recipes : [Recipe])
}


struct ConnectionManager{
    
    var delegate: GetRecipesDelegate?
 
    let headers = [
        "x-rapidapi-host": "recipe-puppy.p.rapidapi.com",
        "x-rapidapi-key": "1d031451bfmsh7cac25834664a15p1614bfjsn868ec26a72e9"
    ]
   
    func fetchData(ing: String,page:Int){

         let url = NSURL(string: "https://recipe-puppy.p.rapidapi.com/?i=\(ing)&p=\(page)")! as URL

        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let err = error { //Error in retriving data
                print(err.localizedDescription)
            }
            if let safeData = data{
                let recipes = self.parseJson(recipeData: safeData)
                self.delegate?.didGetRecipes(recipes: recipes)                
            }
        })
        dataTask.resume()
        
    }
  
    func parseJson(recipeData: Data)-> [Recipe]{
        let decoder = JSONDecoder()
        
        var recipes :[Recipe] = []
        do {
            let decodedData = try  decoder.decode(RecipeData.self, from: recipeData)
            for i in decodedData.results{
                let recipe = Recipe(href: i.href, title: i.title, thumbnail: i.thumbnail, ingredients: i.ingredients)
                recipes.append(recipe)
                print(recipe)
            }
        } catch{
            print(error)
        }

        return recipes
    }
    
}


