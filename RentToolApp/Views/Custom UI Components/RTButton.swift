//
//  CustomButton.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 03.08.25.
//

import UIKit

class RTButton: UIButton {
    
    var cornerRadius: CGFloat
    var title: String = "Button"
    var action : (() -> Void)?

    init(title: String,
         cornerRadius: CGFloat = 8,
         action: (() -> Void)? = nil
    ) {
        self.title = title
        self.action = action
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        var config = UIButton.Configuration.plain()
        setTitle(title, for: .normal)
        config.titleAlignment = .center
        layer.cornerRadius = cornerRadius
        configuration = config
        layer.masksToBounds = true
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.accent.cgColor
        backgroundColor = .rtButton
        tintColor = .rtBackground
        
        addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    }
    @objc
    func handleAction() {
        action?()
    }
}
