//
//  RestaurantModel.swift
//  Food
//
//  Created by Norah Alfari on 01/06/1445 AH.
//

import Foundation

struct RestaurantModel: Identifiable, Codable{
    
    var id: UUID
    var restaurantName: String
    var restaurantDescription:String
    var restaurantImage: URL
    
}
