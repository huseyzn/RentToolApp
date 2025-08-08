//
//  FavoritesViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - Views
    let favoritesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let button = RTButton()
    
    
    let data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    //MARK: - Setup UI Functions
    func setupUI() {
        view.backgroundColor = HomeViewController.mainAppColor
        title = "Favorites"
        navigationItem.backButtonTitle = ""
        navigationItem.backButtonDisplayMode = .minimal
        
        favoritesTableView.backgroundColor = .mainApp
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        view.addSubviewsFromExt(favoritesTableView)
        
        favoritesTableView.pinToSafeArea(of: view)
        
        
        
    }
    
}

//MARK: - Favorites Table View
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        let cellImage = UIImage(systemName: "star.fill")
        config.text = "\(data[indexPath.row]). Item"
        config.image = cellImage
        config.imageProperties.tintColor = .systemYellow
        
        cell.contentConfiguration = config
        cell.backgroundColor = .clear
        return cell
    }
    
}


//MARK: - Preview
#Preview{
    UINavigationController(rootViewController: FavoritesViewController())
}
