//
//  RTAlertController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 27.08.25.
//
import UIKit

class RTAlertController: UIView {

    
    enum ButtonStyle {
        case normal
        case dangerous
    }
    
    private let backgroundView = UIView()
    private let containerView = UIView()
    private let titleLabel = RTLabel(style: .boldTitle, size: 20)
    private let messageLabel = RTLabel(style: .subtitle, size: 14)
    
    // Button array-i
    private var buttons: [RTButton] = []

    init(title: String,
         message: String,
         isError: Bool = false,
         pinToEdge: Bool = true,
         buttons: RTButton...
    ) {
//        super.init(frame: UIScreen.main.bounds) //old version
        super.init(frame: .zero) //new version with auto layout
        translatesAutoresizingMaskIntoConstraints = false
        self.buttons = buttons
        setupUI(title: title, message: message)
        if isError {
            titleLabel.textColor = .systemRed
            messageLabel.textColor = .systemPink.withAlphaComponent(0.8)
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI(title: String, message: String) {
        backgroundView.frame = self.bounds
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        addSubview(backgroundView)

        containerView.backgroundColor = .rtBackground.withAlphaComponent(0.95)
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderWidth = 0.8
        containerView.layer.borderColor = UIColor.rtLabel.cgColor
        addSubview(containerView)
        
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0

        // stackview-a bütün button-ları əlavə etmək
        let stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel] + buttons)
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stack)

        stack.pinToEdges(of: containerView, padding: 30)
        
        containerView.pinToCenter(of: self)
        containerView.configSize(width: UIScreen.main.bounds.width * 0.8)
        
       alpha = 0
       transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut]) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    @discardableResult
    func createButton(title: String, style: ButtonStyle = .normal, action: (() -> Void)? = nil) -> RTButton {
        let button = RTButton(title: title) {
            action?()
            self.removeFromSuperview() // alert-i avtomatik bağlayır
        }
        
        switch style {

        case .normal: break
            
        case .dangerous:
            button.backgroundColor = .systemRed
        }
        
        buttons.append(button)

        // Əgər stackview varsa əlavə et
        if let stack = containerView.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
            stack.addArrangedSubview(button)
        }
        return button
    }
    
    func showTemporarily(duration: TimeInterval = 2.0) {
        // View hierarchy-ə əlavə olunandan sonra
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            UIView.animate(withDuration: 0.25, animations: {
                self?.alpha = 0
                self?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { _ in
                self?.removeFromSuperview()
            }
        }
    }
}
