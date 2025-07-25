//
//  Extensions.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 24.07.25.
//

import UIKit.UIView
extension UIView {
    func applyDynamicBorder(colorName: String, width: CGFloat = 1, cornerRadius: CGFloat = 8) {
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = UIColor(named: colorName)?.cgColor
    }
    
    func setToCardColor(_ opacity: CGFloat = 0.4){
        self.backgroundColor = ToolCard.cardColor.withAlphaComponent(opacity)
    }
    
}


