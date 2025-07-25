//
//  Tool.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import Foundation
import UIKit.UIImageView

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

    var image: UIImage?
    
//    var date = Date()
}
