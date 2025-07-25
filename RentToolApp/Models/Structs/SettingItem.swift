//
//  SettingItem.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 25.07.25.
//

import Foundation
import UIKit.UIImage
struct SettingItem {
    var title: String
    var image: UIImage?
    
    init(title: String, imageName: String? = nil) {
        self.title = title
        self.image = UIImage(systemName: imageName ?? "gearshape.fill")
    }
}
