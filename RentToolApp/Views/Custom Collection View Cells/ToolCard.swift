//
//  ToolCard.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class ToolCard: UICollectionViewCell {

    static let cardColor : UIColor = UIColor(named: "ToolCardColor") ?? .systemBlue
    static let reuseIdentifier = "ToolCard"
    static let borderColor: CGColor = CGColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
    
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
    
    var containerStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = ToolCard.borderColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var labelsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        stackView.layer.borderColor = ToolCard.borderColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    lazy var cardImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var availabilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
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
        
        NSLayoutConstraint.activate([

            labelsStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),

            cardImage.heightAnchor.constraint(equalTo: containerStackView.heightAnchor, multiplier: 0.5),
            cardImage.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 0.9),
        ])
    }

    func configure(with tool: Tool) {
        cardImage.image              = tool.image ?? UIImage(systemName: "photo")
        nameLabel.text               = tool.name
        priceLabel.text              = "₼\(tool.rentalPricePerDay)/gün"
        availabilityLabel.text       = tool.isAvailable ? "Mövcuddur" : "Mövcud deyil"
        availabilityLabel.textColor  = tool.isAvailable ? .systemGreen : .systemRed
    }
}

#Preview {
    ToolCard()
}
