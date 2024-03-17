//
//  AddWishCell.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 17.03.2024.
//

import Foundation
import UIKit

final class AddWishCell: UITableViewCell {
    private enum Constants {
        static let reusedId: String = "AddWishCell"
        
        static let cellBackgroundColor: UIColor = .clear
        static let cellSelectionStyle: UITableViewCell.SelectionStyle = .none
        
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetH: CGFloat = 10
        static let wrapHeight: Double = 150;
        static let wrapBackgroundColor: UIColor = .clear;
        
        static let wishTextTop: Double = 10;
        static let wishTextRadius: Double = 10;
        static let wishTextHeight: Double = 100;
        static let defaultWishText: String = "Your Wish..."
        static let wishTextColor: UIColor = .black
        static let wishTextFont: UIFont! = .systemFont(ofSize: 20, weight: .regular)
        
        static let addWishButtonTop: Double = 10;
        static let addWishButtonTitle: String = "Submit";
        static let addWishButtonRadius: Double = 10;
        static let addWishButtonWidth: Double = 70;
        static let addWishButtonHeight: Double = 25;
        static let addWishButtonBackgroundColor: UIColor = .blue
        static let addWishButtonFont: UIFont! = .systemFont(ofSize: 20, weight: .bold)
        
        static let errorMessage: String = "init(coder:) has not been implemented"
    }
    
    static let reusedId: String = Constants.reusedId
    
    private let wishText: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton(type: .system)
    private var addWish: ((String) -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @objc
    func addWishButtonTapped() {
        addWish?(wishText.text)
        
        wishText.text = ""
    }
    
    func configure(action: @escaping (String) -> ()) {
        addWish = action;
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.errorMessage)
    }
    
    private func configureUI() {
        selectionStyle = Constants.cellSelectionStyle
        backgroundColor = Constants.cellBackgroundColor
        
        let wrap: UIView = UIView()
        
        contentView.addSubview(wrap)
        
        wrap.pin(to: contentView);
        wrap.setHeight(Constants.wrapHeight)
        wrap.isUserInteractionEnabled = true
        wrap.backgroundColor = Constants.wrapBackgroundColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        wrap.addSubview(wishText)
        wrap.addSubview(addWishButton)
        
        configureWishText(wrap: wrap)
        configureAddWishButton()
    }
    
    private func configureWishText(wrap: UIView) {
        wishText.pinHorizontal(to: wrap, Constants.wrapOffsetH)
        wishText.pinTop(to: wrap, Constants.wishTextTop)
        wishText.setHeight(Constants.wishTextHeight)
        wishText.layer.cornerRadius = Constants.wishTextRadius
        wishText.text = Constants.defaultWishText
        wishText.textColor = Constants.wishTextColor
        wishText.font = Constants.wishTextFont
    }
    
    private func configureAddWishButton() {
        addWishButton.setTitle(Constants.addWishButtonTitle, for: .normal)
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.backgroundColor = Constants.addWishButtonBackgroundColor
        addWishButton.layer.cornerRadius = Constants.addWishButtonRadius
        addWishButton.titleLabel?.font = Constants.addWishButtonFont
        addWishButton.pinTop(to: wishText.bottomAnchor, Constants.addWishButtonTop)
        addWishButton.pinHorizontal(to: wishText)
        addWishButton.setWidth(Constants.addWishButtonWidth)
        addWishButton.setHeight(Constants.addWishButtonHeight)
        
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
    }
}
