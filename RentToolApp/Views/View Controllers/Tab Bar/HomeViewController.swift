//
//  HomeViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class HomeViewController: UIViewController {
   
    public static let mainAppColor = UIColor(named: "MainAppColor") ?? .systemBackground
    
    var userRole: UserRole
    
    var data: [Tool] = [
        
        Tool(name: "Laqonda",
             category: .handTool,
             quantity: 5,
             rentedQuantity: 2,
             rentalPricePerDay: 5,
             image: UIImage(named: "laqonda")
            ),
        
        Tool(name: "Drel",
             category: .handTool,
             quantity: 7,
             rentedQuantity: 1,
             rentalPricePerDay: 3,
             image: UIImage(named: "drel")
            ),
        Tool(name: "Generator",
             category: .powerTool,
             quantity: 10,
             rentedQuantity: 10,
             rentalPricePerDay: 10,
             image: UIImage(named: "generator")
            )
    ]
    
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
    func setupUI() {
        view.backgroundColor = HomeViewController.mainAppColor
        title = "Home"
        
        navigationItem.backButtonTitle = ""
        navigationItem.backButtonDisplayMode = .minimal
        
        view.addSubview(toolsCollectionView)
        toolsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        toolsCollectionView.pinToSafeArea(of: view, paddingTop: 15)
        
        toolsCollectionView.dataSource = self
        toolsCollectionView.delegate = self
        
        toolsCollectionView.register(ToolCard.self, forCellWithReuseIdentifier: ToolCard.reuseIdentifier)
        
        toolsCollectionView.backgroundColor = HomeViewController.mainAppColor
        
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
//        data.append(Tool(name: "Ad", category: .handTool, quantity: Int.random(in: 1...10), rentedQuantity: Int.random(in: 0...10), rentalPricePerDay: Double(Int.random(in: 3...20)), image: UIImage(systemName: "star")))
//        toolsCollectionView.reloadData()
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard userRole == .admin else { return }
        let point = gesture.location(in: toolsCollectionView)

        guard let indexPath = toolsCollectionView.indexPathForItem(at: point) else { return }
        
        if gesture.state == .began {
            let selectedTool = data[indexPath.item]
            let alert = UIAlertController(title: selectedTool.name, message: "Aləti silmək istəyirsiniz?", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Sil", style: .destructive, handler: { _ in
                self.data.remove(at: indexPath.item)
                self.toolsCollectionView.deleteItems(at: [indexPath])
            }))

            alert.addAction(UIAlertAction(title: "Ləğv et", style: .cancel))
            present(alert, animated: true)
        }
    }

}


//MARK: - Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToolCard.reuseIdentifier, for: indexPath) as? ToolCard
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = DetailsViewController(tool: self.data[indexPath.row])
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
        print("Sifariş edildi: \(tool.name)")
        if let tabBarControllers = tabBarController?.viewControllers {
            for case let navVC as UINavigationController in tabBarControllers {
                if let historyVC = navVC.viewControllers.first(where: { $0 is HistoryViewController }) as? HistoryViewController {
                    historyVC.data.append(tool)
                    historyVC.historyTableView.reloadData()
                }
            }
        }
    }
}
