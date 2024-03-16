//
//  CustomSlider.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 16.03.2024.
//

import Foundation
import UIKit

final class CustomSlider: UIView {
    enum Constants {
        static let backgroundColor: UIColor = .white
        
        static let titleViewTop: CGFloat = 10
        static let titleViewLeading: CGFloat = 20
        
        static let sliderBottom: CGFloat = -10
        static let sliderLeading: CGFloat = 20
        
        static let errorText: String = "init(coder:) has not been implemented"
    }
    
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUi()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.errorText)
    }
    
    private func configureUi() {
        backgroundColor = Constants.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleViewTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleViewLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading),
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
