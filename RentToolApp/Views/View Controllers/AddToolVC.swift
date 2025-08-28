//
//  AddToolVC.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 08.08.25.
//

import UIKit
import PhotosUI

class AddToolVC: UIViewController, PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        guard let itemProvider = results.first?.itemProvider else { return }
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let uiImage = image as? UIImage {
                    DispatchQueue.main.async {
                        print("Seçilmiş şəkil: \(uiImage)")
                        self?.selectImageIV.image = uiImage
                        self?.selectImageLabel.isHidden = true   // şəkil seçiləndə gizlət
                        self?.selectImageIV.layer.borderColor = UIColor.clear.cgColor
                    }
                }
            }
        }
    }
    
    func pickPhoto() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //MARK: - Views
    
    var fieldsStackView = RTStackView(axis: .vertical,
                                      distribution: .fill,
                                      spacing: 5)
    
    lazy var selectImageIV: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.borderWidth = 1
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImageTapped)))
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
        
    }()
    
    @objc private func selectImageTapped() {
        pickPhoto()
    }
    
    var selectImageLabel = RTLabel(labelText: "Select an Image", style: .largeTitle, size: 18, autoLayout: true, alignment: .center)
    
    
    let toolNameTF = RTTextField(ph: "Tool Name", leftPadding: 10, useAutoLayout: true)
    
    let toolCategoryTF = RTTextField(ph: "Tool Category", leftPadding: 10, useAutoLayout: true)
    
    let toolQuantityTF = RTTextField(ph: "Tool Quantity", kbType: .numberPad, leftPadding: 10, useAutoLayout: true)
    
    let toolPricePerDayTF = RTTextField(ph: "Tool Price Per Day", kbType: .numberPad, leftPadding: 10, useAutoLayout: true)
    
    lazy var saveButton: RTButton = {
        let button = RTButton(title: "Save")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .rtBackground
        view.addSubview(fieldsStackView)
        
        fieldsStackView.addArrangedSubview(selectImageIV)
        
        [toolNameTF,
         toolCategoryTF,
         toolQuantityTF,
         toolPricePerDayTF
        ].forEach {view in
            fieldsStackView.addArrangedSubview(view)
            view.setStandardConstraints(to: view, height: 50)
        }
        
        if selectImageIV.image == nil {
            selectImageIV.addSubview(selectImageLabel)
        }
        
        selectImageIV.configSize(height: 200)
        
        selectImageLabel.pinToCenter(of: selectImageIV)
        fieldsStackView.pinWithFlexibleHeight(to: view, padding: 20)
        
        fieldsStackView.addArrangedSubview(saveButton)
        toolQuantityTF.delegate = self
        toolPricePerDayTF.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    //MARK: - Functions
    @objc
    func dissmisKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func saveButtonClicked() {
        
        guard let toolImage = selectImageIV.image,
              let toolImageData = toolImage.pngData() else {
            showCustomAlert(title: "Error", message: "Please select an image", isError: true)
            return
        }
        guard let toolName = toolNameTF.text, !toolName.isEmpty else {
            showCustomAlert(title: "Error", message: "Tool name cannot be empty", isError: true)
            return
        }
        
        guard let toolCategoryString = toolCategoryTF.text, !toolCategoryString.isEmpty else {
            showCustomAlert(title: "Error", message: "Tool category cannot be empty", isError: true)
            return
        }
        
        guard let toolQuantityString = toolQuantityTF.text, !toolQuantityString.isEmpty,
              let toolQuantity = Int(toolQuantityString) else {
            showCustomAlert(title: "Error", message: "Tool quantity must be a valid number", isError: true)
            return
        }
        
        guard let toolPricePerDayString = toolPricePerDayTF.text, !toolPricePerDayString.isEmpty,
              let toolPricePerDay = Double(toolPricePerDayString) else {
            showCustomAlert(title: "Error", message: "Tool price per day must be a valid number", isError: true)
            return
        }
        
        ///`dummy way! —— to be developed in the future`
        let category: ToolCategory = ToolCategory(rawValue: toolCategoryString) ?? .handTool
        
        let newTool = Tool(
            name: toolName,
            category: category,
            quantity: toolQuantity,
            rentedQuantity: 0,
            rentalPricePerDay: toolPricePerDay,
            tags: nil,
            image: toolImageData
        )
        
        // TODO: newTool'u haradasa yadda saxla (shared data store və ya delegate)
        ///`dummy way! —— to be developed in the future`
        if let tabBarControllers = tabBarController?.viewControllers {
            for case let navVC as UINavigationController in tabBarControllers {
                if let homeVC = navVC.viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController {
                    homeVC.tools.append(newTool)
                    homeVC.toolsCollectionView.reloadData()
                }
            }
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
}

#Preview {
    UINavigationController(rootViewController: AddToolVC())
}

extension AddToolVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == toolQuantityTF || textField == toolPricePerDayTF {
            // Yeni daxil edilən simvolların rəqəm olub olmadığını yoxlamaq
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
}
