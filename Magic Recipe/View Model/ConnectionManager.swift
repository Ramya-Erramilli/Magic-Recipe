//
//  ConnectionManager.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import Foundation

protocol GetRecipesDelegate {
    func didGetRecipes(recipes : [Recipe])
}

protocol ErrorReceived {
    func errorReceived(error:Error)
}

struct ConnectionManager{
    
    var delegate: GetRecipesDelegate?
    var errorDelegate:ErrorReceived?
    
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
//                print("cm",err.localizedDescription)
                //Connection errors
                self.errorDelegate?.errorReceived(error: err)                
            }
            if let safeData = data{
                let recipes = self.parseJson(recipeData: safeData).0
                let errors = self.parseJson(recipeData: safeData).1
                self.delegate?.didGetRecipes(recipes: recipes)
                if let error = errors{
                    //data errors
                    self.errorDelegate?.errorReceived(error: error)
                }
                
            }
        })
        dataTask.resume()
    }
  
    func parseJson(recipeData: Data)-> ([Recipe],Error?){
        let decoder = JSONDecoder()
        var errorHere:Error?
        var recipes :[Recipe] = []
        do {
            let decodedData = try  decoder.decode(RecipeData.self, from: recipeData)
            for i in decodedData.results{
                let recipe = Recipe(href: i.href, title: i.title, thumbnail: i.thumbnail, ingredients: i.ingredients)
                recipes.append(recipe)
            }
        } catch{
            errorHere = error
//            print(errorHere)
        }
        return (recipes,errorHere)
    }
    
}


