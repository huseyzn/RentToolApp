//
//  DetailsViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 24.07.25.
//

import UIKit

class DetailsViewController: UIViewController {

    //MARK: - Initializers
    var tool: Tool
    
    init(tool: Tool) {
        self.tool = tool
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    var containerScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()
    
    var containerStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setToCardColor(0.3)
        return stackView
    }()
    
    var detailsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.setToCardColor(0.1)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 12
        stackView.layer.borderColor = UIColor(named: "primaryBorderColor")?.cgColor
        return stackView
    }()
    
    var toolImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.layer.borderWidth = 0.4
//        image.layer.cornerRadius = 8
        return image
    }()
    var toolNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.layer.borderWidth = 1
        return label
    }()

    var toolPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.layer.borderWidth = 1
        return label
    }()

    var toolAvailableQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var toolAvailabilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.layer.borderWidth = 1

        return label
    }()
    
    
    lazy var orderToolButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sifariş Et", for: .normal)
        button.titleLabel?.font       = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius     = 8
        button.tintColor              = .white
        button.backgroundColor        = .systemBlue
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func orderButtonTapped() {
        print("Ordered \(tool.name) for $\(tool.rentalPricePerDay).\nTime: \(Date().formatted(date: .abbreviated, time: .complete))")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        setupConstraints()
        
    }
    
    func configureUI() {
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(toolImageView)
        containerStackView.addArrangedSubview(detailsStackView)


        [toolNameLabel,
         toolPriceLabel,
         toolAvailabilityLabel,
         toolAvailableQuantityLabel, orderToolButton].forEach
        { view in
            detailsStackView.addArrangedSubview(view)
        }
        
        containerStackView.applyDynamicBorder(colorName: "primaryBorderColor", width: 0.6, cornerRadius: 12)
        
        toolImageView.image             = tool.image ?? UIImage(systemName: "photo")
        toolNameLabel.text              = tool.name
        toolPriceLabel.text             = "₼\(tool.rentalPricePerDay)/gün"
        toolAvailabilityLabel.text      = tool.isAvailable ? "Mövcuddur" : "Mövcud deyil"
        toolAvailabilityLabel.textColor = tool.isAvailable ? .systemGreen : .systemRed
        toolAvailableQuantityLabel.text = "\(tool.availableQuantity) ədəd mövcuddur"
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            containerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            containerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            
            containerStackView.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor),
            
            toolImageView.widthAnchor.constraint(equalToConstant: 200),
            toolImageView.heightAnchor.constraint(equalToConstant: 200),
            
            detailsStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor)
        ])
    }
}

#Preview {
    UINavigationController(rootViewController: DetailsViewController(tool:
                                                                        Tool(
                                                                            name: "Tool Name",
                                                                            category: .handTool,
                                                                            quantity: 5,
                                                                            rentedQuantity: 3,
                                                                            rentalPricePerDay: 10,
                                                                            image: UIImage(systemName: "photo"))
                                                                    )
                           
    )
}
