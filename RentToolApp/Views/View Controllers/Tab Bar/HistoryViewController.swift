//
//  HistoryViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class HistoryViewController: UIViewController {
    
    //MARK: - UI Views
    var historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var data = [Tool]()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    //MARK: - Setup UI Functions
    func setupUI(){
        view.backgroundColor = HomeViewController.mainAppColor
        title = "History"
        
        navigationItem.backButtonTitle = ""
        navigationItem.backButtonDisplayMode = .minimal
        
        view.addSubview(historyTableView)
        
        
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        historyTableView.backgroundColor = .mainApp
        historyTableView.pinToEdges(of: view)
        
    }
    
}


//MARK: - History TableView
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        
        config.text = "\(data[indexPath.row].name) - \(data[indexPath.row].date.formatted())"
        config.secondaryText = "\(data[indexPath.row].rentalPricePerDay) AZN"
        
        cell.backgroundColor = .clear
        cell.contentConfiguration = config
        return cell
    }
    
    
}

//MARK: - Preview
#Preview {
    UINavigationController(rootViewController: HistoryViewController())
}
