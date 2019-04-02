//
//  MenuItem.swift
//  RestaurantApp
//
//  Created by Souley on 27/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation

struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}
