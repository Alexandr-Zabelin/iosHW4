//
//  WishCalendarViewController.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 17.03.2024.
//

import UIKit
import CoreData

final class WishCalendarViewController: UIViewController {
    enum Constants {
        static let contentInset: UIEdgeInsets  = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let collectionTop: Double = 10
        static let cellHeight: Double = 150
        
        static let backgroundColor: UIColor = .white
        
        static let errorMessage: String = "Failed to save event :c"
        
        static let collectionViewHeight: CGFloat = 100
    }
    
    private var wishes: [WishEventModel] = []
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private var calendarManager: CalendarManager = CalendarManager()
    private var addButton: UIBarButtonItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        configureCollection()
        configureAddButton()
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Constants.backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.collectionTop)
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
                layout.minimumInteritemSpacing = .zero
                layout.minimumLineSpacing = .zero
                layout.invalidateLayout()
            }
        
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier:  WishEventCell.reuseIdentifier
        )
    }
    private func configureAddButton() {
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWishEventTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addWishEventTapped() {
        let wishEventCreate = WishEventCreationView()
        wishEventCreate.modalPresentationStyle = .pageSheet
        wishEventCreate.isModalInPresentation = false
        wishEventCreate.onSave = { [weak self] newWish in
            if (!(self?.calendarManager.create(eventModel: newWish) ?? false)) {
                print(Constants.errorMessage)
            }
            
            self?.wishes.append(newWish)
            self?.collectionView.reloadData()

        }
        present(wishEventCreate, animated: true, completion: nil)
    }
}

extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return wishes.count
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        WishEventCell.reuseIdentifier, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }

        wishEventCell.configure(
            with: wishes[indexPath.row]
        )
        
        return wishEventCell
    }
}

extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: Constants.collectionViewHeight)
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
    }
}
