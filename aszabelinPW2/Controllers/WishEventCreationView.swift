//
//  WishEventCreationView.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 17.03.2024.
//

import UIKit

final class WishEventCreationView: UIViewController {
    enum Constants {
        static let cornerRadius: CGFloat = 20.0
        static let stackTopOffset: CGFloat = 40.0
        static let offset: CGFloat = 10.0
        
        static let backgroundColor: UIColor = .white
        
        static let closeButtonImage: UIImage = UIImage(systemName: "xmark") ?? UIImage()
        static let closeButtonTop: CGFloat = 3.0
        static let closeButtonLeft: CGFloat = 3.0
        static let closeButtonWidth: CGFloat = 27.0
        static let closeButtonHeight: CGFloat = 27.0
        
        static let buttonBackgroundColor: UIColor = .blue
        static let buttonHeight: CGFloat = 40.0
        
        static let labelTextColor: UIColor = .white
        static let labelFontSize: CGFloat = 16.0
        
        static var datePickerMode:  UIDatePicker.Mode = .date
        
        static let saveButtonTitle: String = "Save"
        
        static let titleText: String = "Event Title:"
        static let descriptionText: String = "Event Description:"
        static let startDateText: String = "Start Date:"
        static let endDateText: String = "End Date:"
        
        static let titlePlaceholderText: String = "Enter event title"
        static let descriptionPlaceholderText: String = "Enter event description"
    }
    
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private var closeButton: UIButton = UIButton(type: .custom)
    private var saveButton: UIButton = UIButton(type: .custom)
    private var startDate: Date = Date()
    private var endDate: Date = Date()
    private var inputStack: UIStackView = UIStackView()
    var onSave: ((WishEventModel) -> (Void))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        
        let titleLabel = createLabel(withText: Constants.titleText)
        let descriptionLabel = createLabel(withText: Constants.descriptionText)
        let startDateLabel = createLabel(withText: Constants.startDateText)
        let endDateLabel = createLabel(withText: Constants.endDateText)
        
        
        configureTextField(titleTextField, placeholder: Constants.titlePlaceholderText)
        configureTextField(descriptionTextField, placeholder: Constants.descriptionPlaceholderText)
        
        configureDatePicker(startDatePicker, selector: #selector(startDateChanged(_:)))
        configureDatePicker(endDatePicker, selector: #selector(endDateChanged(_:)))
        
        inputStack = UIStackView(arrangedSubviews: [
            titleLabel, titleTextField,
            descriptionLabel, descriptionTextField,
            startDateLabel, startDatePicker,
            endDateLabel, endDatePicker
        ])
        
        inputStack.axis = .vertical
        inputStack.spacing = Constants.offset
        inputStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputStack)
        
        inputStack.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.stackTopOffset)
        inputStack.pinHorizontal(to: view, Constants.offset)
        
        configureCloseButton()
        configureSaveButton()
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
    }
    
    private func configureDatePicker(_ datePicker: UIDatePicker, selector: Selector) {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.backgroundColor = Constants.backgroundColor
        datePicker.datePickerMode = Constants.datePickerMode
        datePicker.addTarget(self, action: selector, for: .valueChanged)
    }
    
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.textColor = Constants.labelTextColor
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize)
        
        return label
    }
    
    @objc private func startDateChanged(_ sender: UIDatePicker) {
        startDate = sender.date
    }
    
    @objc private func endDateChanged(_ sender: UIDatePicker) {
        endDate = sender.date
    }
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.setImage(Constants.closeButtonImage, for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.pinTop(to: view, Constants.closeButtonTop)
        closeButton.pinLeft(to: view, Constants.closeButtonLeft)
        closeButton.setWidth(Constants.closeButtonWidth)
        closeButton.setHeight(Constants.closeButtonHeight)
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    private func configureSaveButton() {
        view.addSubview(saveButton)
        
        saveButton.setTitle(Constants.saveButtonTitle, for: .normal)
        saveButton.backgroundColor = Constants.buttonBackgroundColor
        saveButton.layer.cornerRadius = Constants.cornerRadius
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        saveButton.pinTop(to: inputStack.bottomAnchor, Constants.offset)
        saveButton.pinHorizontal(to: view, Constants.offset)
        saveButton.setHeight(Constants.buttonHeight)
    }
    
    @objc private func saveTapped() {
        if (titleTextField.text == nil || descriptionTextField.text == nil) {
            return
        }
        let event = WishEventModel(title: titleTextField.text ?? "", description: descriptionTextField.text ?? "", startDate: startDate, endDate: endDate)
        
        onSave?(event)
        dismiss(animated: true)
    }
}
