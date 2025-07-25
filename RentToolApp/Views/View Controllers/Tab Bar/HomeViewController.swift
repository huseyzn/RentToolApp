//
//  HomeViewController.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class HomeViewController: UIViewController {
   
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
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 320, height: 320)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainUIComponents()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ToolCard.self, forCellWithReuseIdentifier: ToolCard.reuseIdentifier)
        
        
        if userRole == .admin {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTool))
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeUserRole))
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPress)
    }
    @objc func addTool() {
        data.append(Tool(name: "Ad", category: .handTool, quantity: Int.random(in: 1...10), rentedQuantity: Int.random(in: 0...10), rentalPricePerDay: Double(Int.random(in: 3...20)), image: UIImage(systemName: "star"))
                    )
        collectionView.reloadData()
    }
    
    @objc
    func changeUserRole() {
        if userRole == .admin {
            userRole = .user
        } else {
            userRole = .admin
        }
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard userRole == .admin else { return }
        let point = gesture.location(in: collectionView)

        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        
        if gesture.state == .began {
            let selectedTool = data[indexPath.item]
            let alert = UIAlertController(title: selectedTool.name, message: "Aləti silmək istəyirsiniz?", preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Sil", style: .destructive, handler: { _ in
                self.data.remove(at: indexPath.item)
                self.collectionView.deleteItems(at: [indexPath])
            }))

            alert.addAction(UIAlertAction(title: "Ləğv et", style: .cancel))
            present(alert, animated: true)
        }
    }
    //MARK: - Setup UIs
    
    //MARK: - Main
    func setupMainUIComponents() {
        view.backgroundColor = .systemBackground
        title = "Home"
        navigationItem.largeTitleDisplayMode = .always
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

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
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

#Preview {
    UINavigationController(rootViewController: HomeViewController(userRole: .admin))
}
