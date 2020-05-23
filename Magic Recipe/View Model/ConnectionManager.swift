//
//  ConnectionManager.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//


import Foundation


struct ConnectionManager {
    
    func fetchData() ->[Recipe]{
        var recipes:[Recipe]?
        let headers = [
            "x-rapidapi-host": "recipe-puppy.p.rapidapi.com",
            "x-rapidapi-key": "1d031451bfmsh7cac25834664a15p1614bfjsn868ec26a72e9"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://recipe-puppy.p.rapidapi.com")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let err = error { //Error in retriving data
                //                CustomAlert.createAlert(title: "Error", descr: err.localizedDescription)
                print(err)
            } else { //Got response
                _ = response as? HTTPURLResponse
                //                print(httpResponse)
            }
            
            if let safeData = data{
                recipes = self.parseJson(recipeData: safeData)
            }
        })
        
        dataTask.resume()
        if let recipesNonEmpty =  recipes{
            return recipesNonEmpty
        }
        return []
    }
    
    
    func parseJson(recipeData: Data)-> [Recipe]{
        let decoder = JSONDecoder()
        var recipes :[Recipe] = []
        do {
            let decodedData = try  decoder.decode(RecipeData.self, from: recipeData)
            
            for i in decodedData.results{
                let recipe = Recipe(href: i.href, title: i.title, thumbnail: i.thumbnail, ingredients: i.ingredients)
                recipes.append(recipe)
            }
            
            let recipeData = RecipeData(href: decodedData.href, title: decodedData.title, results: recipes, version: decodedData.version)
           
//            print(decodedData.results[0].ingredients,decodedData.results[0].title)
        } catch{
            print(error)
        }
        return recipes
    }
    
}
