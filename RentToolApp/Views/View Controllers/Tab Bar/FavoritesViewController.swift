//
//  FavoritesViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

///`doesn't work —— to be developed in the future`
class FavoritesViewController: UIViewController {
    
    //MARK: - Views
    let favoritesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let tools: [Tool] = fetchTools()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    //MARK: - Setup UI Functions
    private func setupUI() {
        view.backgroundColor = .rtBackground
        title = "Favorites"
//        navigationItem.backButtonTitle = ""
        navigationItem.backButtonDisplayMode = .minimal
        
        favoritesTableView.backgroundColor = .rtBackground
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        view.addSubviewsFromExt(favoritesTableView)
        
        favoritesTableView.pinToSafeArea(of: view)
    }
    
}

//MARK: - Favorites Table View
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        let cellImage = UIImage(systemName: "star.fill")
        
        let tool = tools[indexPath.row]
        let price = tool.rentalPricePerDay
        let name = tool.name
        
        config.text = "\(name) - \(Int(price)) AZN"
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
