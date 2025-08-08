//
//  Extensions.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 24.07.25.
//

import UIKit
extension UIView {
    //    func applyDynamicBorder(colorName: String, width: CGFloat = 1, cornerRadius: CGFloat = 8) {
    //        self.layer.borderWidth = width
    //        self.layer.cornerRadius = cornerRadius
    //        self.layer.borderColor = UIColor(named: colorName)?.cgColor
    //    }
    
    
    func pinToEdges(of superView: UIView, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -padding),
        ])
    }
    
//    func pinToSafeArea(of superView: UIView, padding: CGFloat = 0) {
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: padding),
//            leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
//            trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
//            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
//        ])
//    }
    
    func pinToSafeArea(of superView: UIView, padding: CGFloat = 0, paddingTop: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: paddingTop ?? padding),
            leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
    }
    
    /// for anchor
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                centerY: NSLayoutYAxisAnchor? = nil,
                centerX: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = leading {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = trailing {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    /// for addsubview
    func addSubviewsFromExt(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    
    // for width and height
    func configSize(height: CGFloat? = nil, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
}

extension UITextField {
    func setStandardConstraints(to superview: UIView, height: CGFloat = 40, horizontalPadding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: horizontalPadding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -horizontalPadding)
        ])
    }
}
