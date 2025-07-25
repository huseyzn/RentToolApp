//
//  AdminHomeVIewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 25.07.25.
//

import UIKit

class AdminHomeVIewController: UIViewController {
    private let vc = HomeViewController(userRole: .admin)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view = vc.view
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToolTapped))
    }
    @objc
    func addToolTapped(){
        
    }
}
