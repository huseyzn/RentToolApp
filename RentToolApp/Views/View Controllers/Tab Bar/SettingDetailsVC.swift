//
//  SettingDetailsVC.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 25.07.25.
//

import UIKit

class SettingDetailsVC: UIViewController {
    let item: SettingItem
    
    init(settingItem: SettingItem){
        self.item = settingItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        view.addSubview(image)
        
        label.text = item.title
        image.image = item.image
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}

#Preview {
    SettingDetailsVC(settingItem: SettingItem(title: "Title"))
}
