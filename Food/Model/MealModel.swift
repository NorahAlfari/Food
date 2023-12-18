//
//  MealModel.swift
//  Food
//
//  Created by Norah Alfari on 01/06/1445 AH.
//

import Foundation

struct MealModel: Identifiable, Codable{
    var id: UUID
    var mealname: String
    var mealImage: URL
    var price: Int
    var restaurant: UUID
    var isOrder: Bool
}
