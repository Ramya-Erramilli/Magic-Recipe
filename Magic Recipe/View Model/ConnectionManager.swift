//
//  ConnectionManager.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//


import Foundation
// Connection manger recipes not avaiblee outside closure
// get recipes, pouplate cell by image and title
// pass href for detaild vc




class ConnectionManager {
    static var recipes:[Recipe] = []
    
    let headers = [
        "x-rapidapi-host": "recipe-puppy.p.rapidapi.com",
        "x-rapidapi-key": "1d031451bfmsh7cac25834664a15p1614bfjsn868ec26a72e9"
    ]
    
    func fetchData(ingredients: String){
        
        var url = NSURL(string: "https://recipe-puppy.p.rapidapi.com/?i=\(ingredients)")! as URL

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
                ConnectionManager.recipes = self.parseJson(recipeData: safeData)
                print(ConnectionManager.recipes)
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
//                ConnectionManager.recipes.append(recipe)
            }
//
//            let recipeData = RecipeData(href: decodedData.href, title: decodedData.title, results: recipes, version: decodedData.version)
//
        } catch{
            print(error)
        }
//        ConnectionManager.recipes = recipes
        return recipes
    }
    
}
