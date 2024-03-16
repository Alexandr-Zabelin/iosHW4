//
//  WishMakerViewController.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 16.03.2024.
//

import UIKit

final class WidhMakerViewController: UIViewController {
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
        static let stackBottom: CGFloat = -40
        static let stackLeading: CGFloat = 20
        
        static let hideButtonType: UIButton.ButtonType = .system
        static let hideButtonTitleShow: String = "Show color picker"
        static let hideButtonTitleHide: String = "Hide color picker"
        static let hideButtonControlState: UIControl.State = .normal
        static let hideButtonLeading: CGFloat = 20
        static let hideButtonTop: CGFloat = 50
        static let hideButtonBackgroundColor: UIColor = .blue
        static let hideButtonColor: UIColor = .white
        static let hideButtonCornerRadius: CGFloat = 20
        static let hideButtonFont: UIFont! = .systemFont(ofSize: 24, weight: .bold)
        static let hideButtoncontentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    
    private var titleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var hideButton: UIButton = UIButton(type: Constants.hideButtonType)
    private var stack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureTitle()
        configureDescription()
        configureHideButton()
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
    
    private func configureHideButton() {
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setTitle(getHideButtonTitle(), for: Constants.hideButtonControlState)
        hideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        hideButton.backgroundColor = Constants.hideButtonBackgroundColor
        hideButton.layer.cornerRadius = Constants.hideButtonCornerRadius
        hideButton.tintColor = Constants.hideButtonColor
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
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
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
            }
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom),
        ])
    }
}

