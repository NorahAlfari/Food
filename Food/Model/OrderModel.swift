//
//  OrderModel.swift
//  Food
//
//  Created by Norah Alfari on 03/06/1445 AH.
//

import Foundation

struct OrderModel: Identifiable, Codable{
    var id: UUID
    var totalPrice: Int
    var userID: UUID
    var createdAt: String
    
}
