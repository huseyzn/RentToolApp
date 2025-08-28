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
    
    lazy var label: RTLabel = {
       let label = RTLabel(autoLayout: true)
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
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
    
    private func setupUI(){
        view.backgroundColor = .rtBackground
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
