//
//  RTLabel.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 27.08.25.
//

import UIKit

enum LabelStyle {
    case title
    case boldTitle
    case semiBoldTitle
    case largeTitle
    case subtitle
    case boldSubtitle
    case semiBoldSubtitle
    case errorTitle
}

class RTLabel: UILabel {
    
    var labelText: String
    private var style: LabelStyle
    var size: CGFloat
    var alignment : NSTextAlignment
    init(labelText: String = "",
         style: LabelStyle = .title,
         size: CGFloat = 17,
         autoLayout: Bool = false,
         alignment: NSTextAlignment = .center
    ) {
        self.labelText = labelText
        self.style = style
        self.size = size
        self.alignment = alignment
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = !autoLayout
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        text = labelText
        
        switch style {
        case .title:
            textColor = .rtLabel
            font = .systemFont(ofSize: size)
        case .boldTitle:
            textColor = .rtLabel
            font = UIFont.boldSystemFont(ofSize: size)
        case .semiBoldTitle:
            textColor = .rtLabel
            font = UIFont.systemFont(ofSize: size, weight: .semibold)
        case .largeTitle:
            textColor = .rtLabel
            font = .preferredFont(forTextStyle: .largeTitle)
        case .subtitle:
            textColor = .rtSecondaryLabel
            font = .systemFont(ofSize: size)
        case .boldSubtitle:
            textColor = .rtSecondaryLabel
            font = UIFont.boldSystemFont(ofSize: size)
        case .semiBoldSubtitle:
            textColor = .rtSecondaryLabel
            font = .systemFont(ofSize: size, weight: .semibold)

        case .errorTitle:
            textColor = .systemRed
            font = .systemFont(ofSize: size)
        }
    }
}
