//
//  ConnectionManager.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//


import Foundation

struct ConnectionManager {    
    func fetchData() {
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
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
            }
            
            if let safeData = data{
                self.parseJson(recipeData: safeData)
            }
        })

        dataTask.resume()
    }
    
    
    func parseJson(recipeData: Data){
        var decoder = JSONDecoder()
        
         do {
             let decodedData = try  decoder.decode(RecipeData.self, from: recipeData)
            print(decodedData.results[0].ingredients,decodedData.results[0].title)
         } catch{
             print(error)
         }
        
    }
    
}
