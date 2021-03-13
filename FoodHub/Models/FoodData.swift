//
//  FoodData.swift
//  FoodHub
//
//  Created by Bhavesh Sharma on 13/03/21.
//

import Foundation

class FoodData: Codable{
    var img: String
    var name: String
    var calogries: String
    var price: Double
    var detail: String
    
    init(img: String, name: String, calogries: String, price: Double, detail: String) {
        self.img = img
        self.name = name
        self.calogries = calogries
        self.price = price
        self.detail = detail
    }
    
}
