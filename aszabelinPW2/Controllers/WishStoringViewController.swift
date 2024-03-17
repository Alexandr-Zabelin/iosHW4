//
//  WishStoringViewController.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 17.03.2024.
//

import Foundation
import UIKit

final class WishStoringViewController: UIViewController {
    enum Constants {
        static let addWishCellCount: Int = 1;
        static let addWishSectionIndex: Int = 0;
        static let numberOfSections: Int = 2;
        
        static let wishesTableBackgroundColor: UIColor = .lightGray
        static let wishesTableSeparatorStyle: UITableViewCell.SeparatorStyle = .none
        static let wishesTableCornerRadius: CGFloat = 15
        static let wishesTableConst: CGFloat = 20
        
        static let viewBackgroundColor: UIColor = .blue
    
        static let wishesKey: String = "WishesKey"
    }
    
    private let defaults = UserDefaults.standard
    private var wishesTable: UITableView = UITableView()
    private var wishes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        wishes = defaults.array(forKey: Constants.wishesKey) as? [String] ?? []
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.viewBackgroundColor
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(wishesTable)
        
        wishesTable.backgroundColor = Constants.wishesTableBackgroundColor
        wishesTable.dataSource = self
        wishesTable.separatorStyle = Constants.wishesTableSeparatorStyle
        wishesTable.layer.cornerRadius = Constants.wishesTableCornerRadius
        wishesTable.pin(to: view, Constants.wishesTableConst)
        
        wishesTable.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reusedId)
        wishesTable.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reusedId)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Constants.addWishSectionIndex ? Constants.addWishCellCount : wishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constants.addWishSectionIndex {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reusedId, for: indexPath)
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.configure(action: {[weak self] wish in
                if wish.isEmpty {
                    return
                }
                
                self?.wishes.append(wish)
                self?.wishesTable.reloadData()
                self?.defaults.set(self?.wishes, forKey: Constants.wishesKey)
            })

            return addWishCell
        }
            
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reusedId, for: indexPath)
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        
        wishCell.configure(with: wishes[indexPath.row])
        
        return wishCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
}
