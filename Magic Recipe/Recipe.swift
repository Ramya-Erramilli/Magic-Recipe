//
//  Recipe.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import Foundation
struct RecipeData: Decodable{
    
    let href:   String
    let title:  String
    let results: [Recipe]
    let version:  Double
   
}
struct Recipe: Decodable {
    let href:   String
    let title:  String
    let thumbnail:  String
    let ingredients: String
}
