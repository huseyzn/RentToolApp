//
//  SettingsViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class SettingsViewController: UIViewController {
    

    
    let items = [
        SettingItem(title: "About"),
        SettingItem(title: "Privacy Policy"),
        SettingItem(title: "Terms of Service")
    ]
    
    let settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .rtBackground
        title = "Settings"
        navigationItem.backButtonTitle = "Tənzimləmələr"
        navigationItem.backButtonDisplayMode = .minimal

        view.addSubview(settingsTableView)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        settingsTableView.backgroundColor = .clear
        settingsTableView.pinToSafeArea(of: view)
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        
        let item = items[indexPath.row]
        
        config.text = item.title
        config.image = item.image
        
        cell.contentConfiguration = config
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SettingDetailsVC(settingItem: items[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: SettingsViewController())
    
}
