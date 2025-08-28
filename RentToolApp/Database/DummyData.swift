//
//  DummyData.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import Foundation
import UIKit.UIImage

///`dummy way! —— to be developed in the future`
func fetchTools() -> [Tool] {
    let tool1 = Tool(name: "Chainsaw",
         category: .handTool,
         quantity: 5,
         rentedQuantity: 2,
         rentalPricePerDay: 5,
         image: UIImage(named: "laqonda")?.pngData()
        )
    
    let tool2 = Tool(name: "Drill",
         category: .handTool,
         quantity: 7,
         rentedQuantity: 1,
         rentalPricePerDay: 3,
         image: UIImage(named: "drel")?.pngData()
        )
    
    let tool3 = Tool(name: "Generator",
         category: .powerTool,
         quantity: 10,
         rentedQuantity: 10,
         rentalPricePerDay: 10,
         image: UIImage(named: "generator")?.pngData()
        )
    return [tool1, tool2, tool3]
}
