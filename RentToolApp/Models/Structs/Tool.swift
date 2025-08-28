//
//  Tool.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import Foundation
import UIKit.UIImageView

///`to be developed in the future`
struct Tool : Identifiable/*, Codable*/ {
    var id = UUID()
    
    var name: String
    
    var category: ToolCategory
    
    var quantity: Int {
        didSet {
            if rentedQuantity > quantity {
                rentedQuantity = quantity
            }
        }
    }
    
    var rentedQuantity: Int {
        didSet {
            if rentedQuantity > quantity {
                rentedQuantity = quantity
            }
        }
    }
    
    var availableQuantity: Int {
        return quantity - rentedQuantity
    }
    
    var isAvailable: Bool {
        return availableQuantity > 0
    }
    
    var rentalPricePerDay: Double
    
    var tags: [String]?

    var image: Data?
    
    var date: Date
    
    init(id: UUID = UUID(), name: String, category: ToolCategory, quantity: Int, rentedQuantity: Int, rentalPricePerDay: Double, tags: [String]? = nil, image: Data? = nil, date: Date = Date()) {
        self.id = id
        self.name = name
        self.category = category
        self.quantity = quantity
        self.rentedQuantity = rentedQuantity
        self.rentalPricePerDay = rentalPricePerDay
        self.tags = tags
        self.image = image
        self.date = date
    }
}
