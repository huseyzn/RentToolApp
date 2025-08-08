//
//  CustomButton.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 03.08.25.
//

import UIKit

class RTButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .tabBar
        config.titleAlignment = .center
        
        configuration = config
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.label.cgColor
    }
}
