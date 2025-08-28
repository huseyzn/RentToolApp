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
        view.layer.borderColor = UIColor.rtButton.cgColor
        view.layer.cornerRadius = 12
        view.clipsToBounds                                  = true
        view.backgroundColor = ToolCard.cardColor
        return view
    }()

    var containerStackView = RTStackView(axis: .vertical,
                                         distribution: .fill,
                                         alignment: .fill,
                                         spacing: 8,
                                         margins: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
                                         )

    let detailsStackView = RTStackView(axis: .vertical,
                                       distribution: .fill,
                                       alignment: .leading,
                                       spacing: 10,
                                       margins: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12),
                                       cornerRadius: 12,
                                       borderWidth: 0.7,
                                       borderColor: .rtButton
    )
    
    var toolImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode                               = .scaleAspectFit
        image.clipsToBounds                             = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        return image
    }()
    var toolNameLabel = RTLabel(style: .largeTitle, autoLayout: true)
    
    var toolPriceLabel = RTLabel(style: .semiBoldSubtitle, size: 18, autoLayout: true)
    
    var toolAvailableQuantityLabel = RTLabel(style: .subtitle, size: 14, autoLayout: true)

    var toolAvailabilityLabel = RTLabel(style: .semiBoldTitle, size: 16)
    
    lazy var orderToolButton: RTButton = {
        let button                      = RTButton(title: "Order")
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    ///`dummy way! —— to be developed in the future`
    @objc func orderButtonTapped() {
        

        if !tool.isAvailable {
            showCustomAlert(title: "This tool is not available", message: "Please try again later.")
            return
        }

        print("Ordered \(tool.name) for ₼\(tool.rentalPricePerDay).\nTime: \(Date().formatted(date: .abbreviated, time: .complete))")
        delegate?.didOrderTool(tool)
        navigationController?.popViewController(animated: true)

    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .rtBackground
        
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
        
        
        if let data = tool.image {
            toolImageView.image = UIImage(data: data)
        }else {
            toolImageView.image = UIImage(systemName: "photo")
        }
        
        toolNameLabel.text              = tool.name
        toolPriceLabel.text             = "₼\(tool.rentalPricePerDay)/day"
        toolAvailabilityLabel.text      = tool.isAvailable ? "Available" : "Not available"
        toolAvailabilityLabel.textColor = tool.isAvailable ? .systemGreen : .systemRed
        toolAvailableQuantityLabel.text = "\(tool.availableQuantity) available"
    }
    
    func setupConstraints(){
        
        containerScrollView.pinToSafeArea(of: view, padding: 10, paddingTop: 20)
        
        wrapperView.pinToEdges(of: containerScrollView)
        
        containerStackView.pinToEdges(of: wrapperView)
        
        toolImageView.configSize(height: 200)
        
        orderToolButton.configSize(height: 40, width: 150)
        
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
                                                                            image: UIImage(systemName: "photo")?.pngData()
                                                                        )
                                                                     
                                                                    )
    )
}
