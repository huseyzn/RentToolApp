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
    weak var delegate: ToolSelectionDelegate?
    
    var containerScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()

    var wrapperView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1) // DÜZGÜN
        view.layer.cornerRadius = 12
        view.backgroundColor = ToolCard.cardColor
        return view
    }()
    
    var containerStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis                                      = .vertical
        stackView.distribution                              = .fill
        stackView.alignment                                 = .fill
        stackView.spacing                                   = 8
        stackView.isLayoutMarginsRelativeArrangement        = true
        stackView.layoutMargins                             = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var detailsStackView : UIStackView = {
        let stackView                                       = UIStackView()
        stackView.axis                                      = .vertical
        stackView.distribution                              = .fill
        stackView.spacing                                   = 10
        stackView.alignment                                 = .leading
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement        = true
        stackView.layoutMargins                             = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        stackView.layer.borderWidth                         = 1
        stackView.layer.cornerRadius                        = 12
        stackView.layer.borderColor                         = CGColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        return stackView
    }()
    
    var toolImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode                               = .scaleAspectFit
        image.clipsToBounds                             = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var toolNameLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment                             = .center
        label.numberOfLines                             = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var toolPriceLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment                             = .center
        label.textColor                                 = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var toolAvailableQuantityLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = UIFont.systemFont(ofSize: 14)
        label.textAlignment                             = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var toolAvailabilityLabel: UILabel = {
        let label                                       = UILabel()
        label.font                                      = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment                             = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var orderToolButton: RTButton = {
        let button                      = RTButton()
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        button.setTitle("Sifariş et", for: .normal)
        return button
    }()
    
    @objc func orderButtonTapped() {
        print("Ordered \(tool.name) for $\(tool.rentalPricePerDay).\nTime: \(Date().formatted(date: .abbreviated, time: .complete))")
        delegate?.didOrderTool(tool)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
        
    }
    
    func configureUI() {
        view.backgroundColor = .mainApp

        view.addSubview(containerScrollView)
        containerScrollView.addSubview(wrapperView)
        
        wrapperView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(toolImageView)
        containerStackView.addArrangedSubview(detailsStackView)

        [toolNameLabel,
         toolPriceLabel,
         toolAvailabilityLabel,
         toolAvailableQuantityLabel, orderToolButton].forEach
        { view in
            detailsStackView.addArrangedSubview(view)
        }
        
        
        toolImageView.image             = tool.image ?? UIImage(systemName: "photo")
        toolNameLabel.text              = tool.name
        toolPriceLabel.text             = "₼\(tool.rentalPricePerDay)/gün"
        toolAvailabilityLabel.text      = tool.isAvailable ? "Mövcuddur" : "Mövcud deyil"
        toolAvailabilityLabel.textColor = tool.isAvailable ? .systemGreen : .systemRed
        toolAvailableQuantityLabel.text = "\(tool.availableQuantity) ədəd mövcuddur"
    }
    
    func setupConstraints(){
        
        containerScrollView.pinToSafeArea(of: view, padding: 10, paddingTop: 20)
        
        wrapperView.pinToEdges(of: containerScrollView)

        containerStackView.pinToEdges(of: wrapperView)
        
        toolImageView.configSize(height: 200)
        
//        orderToolButton.configSize(height: 50, width: 100)
        
        wrapperView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
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
