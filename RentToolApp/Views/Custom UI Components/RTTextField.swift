//
//  RTTextField.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 08.08.25.
//

import UIKit

class RTTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        borderStyle = .none
        
        backgroundColor = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.05)
            : UIColor.lightGray.withAlphaComponent(0.1)
        }
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.toolCard.cgColor
        textColor = .tabBar
        font = .systemFont(ofSize: 16)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
