//
//  AddToolVC.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 08.08.25.
//

import UIKit

class AddToolVC: UIViewController {

    
    //MARK: - Views
    var fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
//        stack.isLayoutMarginsRelativeArrangement = true
//        stack.layoutMargins = .init(top:, left:, bottom:, right:)
        return stack
    }()
    
    let toolNameTextField: RTTextField = {
        let field = RTTextField()
         field.translatesAutoresizingMaskIntoConstraints = false
         field.placeholder = "Tool Name"
         return field
     }()
    
    let toolCategoryTextField: RTTextField = {
       let field = RTTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Tool Category"
        return field
    }()
    
    let toolQuantityTextField: RTTextField = {
        let field = RTTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Tool Quantity"
        field.keyboardType = .numberPad
        return field
    }()
    
    lazy var saveButton: RTButton = {
        let button = RTButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = .mainApp
        
        toolNameTextField.placeholder = "Tool Name"
        
        view.addSubview(fieldsStackView)

        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        [toolNameTextField,
         toolCategoryTextField,
         toolQuantityTextField,
        ].forEach{ view in
            fieldsStackView.addArrangedSubview(view)
            view.setStandardConstraints(to: view, height: 50)
        }
        fieldsStackView.addArrangedSubview(saveButton)
        toolQuantityTextField.delegate = self
        
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
        guard let toolName = toolNameTextField.text, !toolName.isEmpty else {
            showAlert(title: "Error", message: "Tool name cannot be empty")
            return
        }
        
        guard let toolCategory = toolCategoryTextField.text, !toolCategory.isEmpty else {
            showAlert(title: "Error", message: "Tool category cannot be empty")
            return
        }
        
        guard let toolQuantityString = toolQuantityTextField.text, !toolQuantityString.isEmpty else {
            showAlert(title: "Error", message: "Tool quantity cannot be empty")
            return
        }
        navigationController?.popToRootViewController(animated: true)
//        let newTool = Tool(name: toolName, category: toolCategory, quantity: toolQuantity)
        
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: AddToolVC())
}

extension AddToolVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == toolQuantityTextField {
            // Yeni daxil edilən simvolların rəqəm olub olmadığını yoxla
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
}
