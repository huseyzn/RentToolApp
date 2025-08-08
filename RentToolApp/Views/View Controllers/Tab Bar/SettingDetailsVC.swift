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
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .mainApp
        navigationItem.backButtonTitle = ""
        navigationItem.backButtonDisplayMode = .minimal
        view.addSubviewsFromExt(label, image)
        label.text = item.title
        image.image = item.image
        
        label.anchor(centerY: view.centerYAnchor, centerX: view.centerXAnchor)
        image.anchor(top: label.bottomAnchor, centerX: view.centerXAnchor, paddingTop: 20, width: 80, height: 80)
    }
    
}

#Preview {
    SettingDetailsVC(settingItem: SettingItem(title: "Title"))
}
