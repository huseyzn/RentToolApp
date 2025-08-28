//
//  HomeViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var userRole: UserRole
    
    var tools: [Tool] = fetchTools()
    
    init(userRole: UserRole) {
        self.userRole = userRole
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    var toolsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 320, height: 320)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view

    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    //MARK: - Setup UIs
    private func setupUI() {
        view.backgroundColor = .rtBackground
        title = "Home"
        navigationItem.backButtonDisplayMode = .minimal
        
        view.addSubview(toolsCollectionView)
        toolsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        toolsCollectionView.pinToSafeArea(of: view)
        
        toolsCollectionView.dataSource = self
        toolsCollectionView.delegate = self
        
        toolsCollectionView.register(ToolCard.self, forCellWithReuseIdentifier: ToolCard.reuseIdentifier)
        
        toolsCollectionView.backgroundColor = .rtBackground
        
        if userRole == .admin {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTool))
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        toolsCollectionView.addGestureRecognizer(longPress)
    }
    
    //MARK: - Button Functions
    @objc func addTool() {
        let vc = AddToolVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard userRole == .admin else { return }
        let point = gesture.location(in: toolsCollectionView)
        
        guard let indexPath = toolsCollectionView.indexPathForItem(at: point) else { return }
        
        if gesture.state == .began {
            let selectedTool = tools[indexPath.item]
            let alert = RTAlertController(title: selectedTool.name, message: "Do you want to delete this tool?")
            alert.createButton(title: "Delete", style: .dangerous) {
                self.tools.remove(at: indexPath.item)
                self.toolsCollectionView.deleteItems(at: [indexPath])
            }
            alert.createButton(title: "Cancel")
            self.view.addSubview(alert)
            alert.pinToEdges(of: view)
        }
    }
    
}

//MARK: - Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tools.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToolCard.reuseIdentifier, for: indexPath) as? ToolCard
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: tools[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = DetailsViewController(tool: self.tools[indexPath.row])
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

#Preview {
    UINavigationController(rootViewController: HomeViewController(userRole: .admin))
}

// MARK: - ToolSelectionDelegate
extension HomeViewController: ToolSelectionDelegate {
    func didOrderTool(_ tool: Tool) {
        
        if tool.rentedQuantity == tool.quantity {
            
            return
        }
        ///`dummy way! —— to be developed in the future`
        
        showTemporarilyAlert(title: "Order Placed", message: "Your order has been placed successfully.", duration: 2)
        
        print("Sifariş edildi: \(tool.name)")
        if let tabBarControllers = tabBarController?.viewControllers {
            for case let navVC as UINavigationController in tabBarControllers {
                if let historyVC = navVC.viewControllers.first(where: { $0 is HistoryViewController }) as? HistoryViewController {
                    historyVC.data.append(tool)
                    historyVC.historyTableView.reloadData()
                }
            }
        }
        ///`dummy way! —— to be developed in the future`
        if let index = tools.firstIndex(where: { $0.id == tool.id }) {
            var updatedTool = tools[index]
            updatedTool.rentedQuantity += 1
            tools[index] = updatedTool
            toolsCollectionView.reloadData()
        }
    }
    

}
