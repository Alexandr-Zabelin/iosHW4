//
//  WishMakerViewController.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 16.03.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    enum Constants {
        static let textColor: UIColor = .white
        
        static let titleValue: String = "WishMaker"
        static let titleFontSize: CGFloat = 32
        static let titleLeading: CGFloat = 20
        static let titleTop: CGFloat = 30
        
        static let descriptionValue: String = "You can pick any color you want..."
        static let descriptionFontSize: CGFloat = 24
        static let descriptionLeading: CGFloat = 20
        static let descriptionTop: CGFloat = 20
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let aplha: String = "Alpha"
        
        static let aplhaInitValue: Float = 1
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 60
        static let stackLeading: CGFloat = 20
        
        static let hideButtonType: UIButton.ButtonType = .system
        static let hideButtonTitleShow: String = "Show color picker"
        static let hideButtonTitleHide: String = "Hide color picker"
        static let hideButtonControlState: UIControl.State = .normal
        static let hideButtonLeading: CGFloat = 20
        static let hideButtonTop: CGFloat = 50
        static let hideButtonBackgroundColor: UIColor = .white
        static let hideButtonColor: UIColor = .white
        static let hideButtonCornerRadius: CGFloat = 20
        static let hideButtonFont: UIFont! = .systemFont(ofSize: 24, weight: .bold)
        static let hideButtoncontentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        static let wishesButtonTitle: String = "My Wishes"
        static let wishesButtonBottom: CGFloat = -30
        static let wishesButtonFont: UIFont! = .systemFont(ofSize: 20, weight: .bold)
        static let wishButtonBottom: Double = 45
        static let wishButtonSide: Double = 0
        
        static let spacing: Double = 10
        
        static let scheduleWishButtonHeight: Double = 35
        static let scheduleWishButtonCornerRadius: Double = 15
        static let scheduleWishButtonBottom: Double = 0
        static let scheduleWishButtonSide: Double = 0
        static let scheduleWishButtonText: String = "Schedule wish granting"
        static let scheduleWishButtonBackgroundColor: UIColor = .white
        static let scheduleWishButtonTitleColor: UIColor = .black
    }
    
    private var titleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var hideButton: UIButton = UIButton(type: Constants.hideButtonType)
    private var stack: UIStackView = UIStackView()
    private var addWishButton: UIButton = UIButton(type: .system)
    private var actionStack: UIStackView = UIStackView()
    private var scheduleWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureHideButton()
        configureActionStack()
        configureSliders()
    }
    
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.titleValue
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = Constants.textColor
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeading),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop),
        ])
        
    }
    
    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = Constants.descriptionValue
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = Constants.textColor
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionLeading),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTop),
        ])
    }
    
    private func configureActionStack() {
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = Constants.spacing
        
        for button in [addWishButton, scheduleWishButton] {
            actionStack.addArrangedSubview(button)
        }
        
        configureScheduleMissions()
        configureAddWishButton()
        syncButtonsColor()
        actionStack.pinBottom(to: view, Constants.stackBottom)
        actionStack.pinHorizontal(to: view, Constants.stackLeading)
    }
    
    private func configureScheduleMissions() {
        scheduleWishButton.setHeight(Constants.scheduleWishButtonHeight)
        scheduleWishButton.pinBottom(to: actionStack, Constants.scheduleWishButtonBottom)
        scheduleWishButton.pinHorizontal(to: actionStack, Constants.scheduleWishButtonSide)
           
        scheduleWishButton.titleLabel?.font = Constants.wishesButtonFont
        scheduleWishButton.backgroundColor = Constants.hideButtonBackgroundColor
        scheduleWishButton.layer.cornerRadius = Constants.hideButtonCornerRadius
        scheduleWishButton.setTitle(Constants.scheduleWishButtonText, for: .normal)
        scheduleWishButton.contentEdgeInsets = Constants.hideButtoncontentEdgeInsets
           
        scheduleWishButton.layer.cornerRadius = Constants.scheduleWishButtonCornerRadius
        scheduleWishButton.addTarget(self, action: #selector(scheduleWishButtonPressed), for: .touchUpInside)
       }
    
    @objc func scheduleWishButtonPressed() {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureHideButton() {
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setTitle(getHideButtonTitle(), for: Constants.hideButtonControlState)
        hideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        hideButton.backgroundColor = Constants.hideButtonBackgroundColor
        hideButton.layer.cornerRadius = Constants.hideButtonCornerRadius
        hideButton.titleLabel?.font = Constants.hideButtonFont
        hideButton.contentEdgeInsets = Constants.hideButtoncontentEdgeInsets
        
        view.addSubview(hideButton)
        
        NSLayoutConstraint.activate([
            hideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.hideButtonTop),
        ])
    }
    
    private func getHideButtonTitle() -> String {
        return stack.isHidden ? Constants.hideButtonTitleShow : Constants.hideButtonTitleHide
    }
    
    @objc
    private func buttonTapped() {
        stack.isHidden.toggle()
        hideButton.setTitle(getHideButtonTitle(), for:Constants.hideButtonControlState)
    }
    
    private func configureAddWishButton() {
        addWishButton.titleLabel?.font = Constants.wishesButtonFont
        addWishButton.setTitle(Constants.wishesButtonTitle, for: Constants.hideButtonControlState)
        addWishButton.backgroundColor = Constants.hideButtonBackgroundColor
        addWishButton.layer.cornerRadius = Constants.hideButtonCornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        addWishButton.contentEdgeInsets = Constants.hideButtoncontentEdgeInsets
        
        
        addWishButton.pinBottom(to: actionStack, Constants.wishButtonBottom)
        addWishButton.pinHorizontal(to: actionStack, Constants.wishButtonSide)
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    private func configureSliders() {
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        let redSlider = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let greenSlider = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let blueSlider = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let alphaSlider = CustomSlider(title: Constants.aplha, min: Constants.sliderMin, max: Constants.sliderMax)
        
        alphaSlider.slider.value = Constants.aplhaInitValue
        
        for slider in [redSlider, greenSlider, blueSlider, alphaSlider] {
            stack.addArrangedSubview(slider)
            
            slider.valueChanged = { [weak self] _ in
                self?.view.backgroundColor = UIColor(red: CGFloat(redSlider.slider.value) , green: CGFloat(greenSlider.slider.value), blue: CGFloat(blueSlider.slider.value), alpha: CGFloat(alphaSlider.slider.value))
                
                self?.syncButtonsColor()
            }
        }
        
        stack.pinCenterX(to: view)
        stack.pinLeft(to: view, Constants.stackLeading)
        stack.pinBottom(to: addWishButton.topAnchor, Constants.stackBottom)
    }
    
    private func syncButtonsColor() {
        for button in [hideButton, addWishButton, scheduleWishButton] {
            button.setTitleColor(view.backgroundColor, for: .normal)
        }
    }
}

