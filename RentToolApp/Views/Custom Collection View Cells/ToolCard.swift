//
//  ToolCard.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class ToolCard: UICollectionViewCell {

    static let cardColor : UIColor = .accent
    static let reuseIdentifier = "ToolCard"
    static let labelColor : UIColor = .rtLabel
    static let secondaryLabelColor : UIColor = .rtSecondaryLabel
    
    let csvMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    let lsvMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    
    var containerView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ToolCard.cardColor
        view.layer.shadowOffset = CGSize(width: 1, height: 3)
        view.layer.shadowOpacity = 0.2
        return view
    }()
        
    lazy var containerStackView = RTStackView(axis: .vertical,
                                              distribution: .fillProportionally,
                                              alignment: .center,
                                              spacing: 8,
                                              margins: csvMargins,
                                              cornerRadius: 10,
                                              borderWidth: 1)
    
    lazy var labelsStackView = RTStackView(axis: .vertical,
                                           distribution: .fillProportionally,
                                           alignment: .leading,
                                           spacing: 0,
                                           margins: lsvMargins,
                                           cornerRadius: 10,
                                           borderWidth: 1)
    
    lazy var cardImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        return image
    }()
    
    var nameLabel: RTLabel = {
        let label = RTLabel(style: .boldTitle, size: 18, autoLayout: true)
        label.numberOfLines = 1
        return label
    }()

    var priceLabel = RTLabel(style: .subtitle, size: 16, autoLayout: true)
    
    var availabilityLabel = RTLabel(style: .boldTitle, size: 14, autoLayout: true)
    
    var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.backgroundColor = .systemGray3.withAlphaComponent(0.4)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(cardImage)
        containerStackView.addArrangedSubview(labelsStackView)

        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(priceLabel)
        labelsStackView.addArrangedSubview(availabilityLabel)
    }
    func setupConstraints() {
        containerView.pinToEdges(of: contentView, padding: 8)
        containerStackView.pinToEdges(of: containerView)
        
        labelsStackView.anchor(leading: containerStackView.leadingAnchor, trailing: containerStackView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            cardImage.heightAnchor.constraint(equalTo: containerStackView.heightAnchor, multiplier: 0.5),
            cardImage.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 0.9),
        ])
    }

    func configure(with tool: Tool) {
        if let data = tool.image {
            cardImage.image = UIImage(data: data)
        } else {
            cardImage.image = UIImage(systemName: "photo")
        }
        nameLabel.text               = tool.name
        priceLabel.text              = "₼\(tool.rentalPricePerDay)/day"
        availabilityLabel.text       = tool.isAvailable ? "Available" : "Not Available"
        availabilityLabel.textColor  = tool.isAvailable ? .systemGreen : .systemRed
    }
}

#Preview {
    ToolCard()
}
