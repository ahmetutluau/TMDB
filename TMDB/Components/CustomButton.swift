//
//  CustomButton.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import UIKit

enum CustomButtonTypes {
    case center
    case arrow
}

class CustomButton: UIButton {
    lazy var buttonClicked: () -> () = {}
    var buttonColor: UIColor?
    
    var isButtonEnabled: Bool? {
        didSet {
            guard let validatedIsButtonEnabled = isButtonEnabled else { return }
            isUserInteractionEnabled = validatedIsButtonEnabled
            isEnabled = validatedIsButtonEnabled
            backgroundColor = validatedIsButtonEnabled ? buttonColor : .gray

        }
    }
    
    convenience init(type: CustomButtonTypes,
                     title: String? = nil,
                     font: UIFont? = .systemFont(ofSize: 24),
                     titleColor: UIColor? = .white,
                     backgroundColor: UIColor? = .clear,
                     cornerRadius: CGFloat = 24,
                     image: UIImage? = nil,
                     width: CGFloat = 24,
                     height: CGFloat = 16,
                     inset: CGFloat = 20,
                     isCenteredTitle: Bool = false,
                     underLineStyle:Bool = false) {
        self.init()
        
        contentHorizontalAlignment = .center
//        contentEdgeInsets = .zero
        setImage(image, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        titleLabel?.numberOfLines = 1
        titleLabel?.lineBreakMode = .byWordWrapping
        clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        imageView?.contentMode = .scaleAspectFit
        
        if underLineStyle {
            guard let title = title else { return }
            setAttributedTitle(NSAttributedString(string: title,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue ]), for: .normal)
        }
        
        switch type {
        case .center:
            setupCenterType(width: width, height: height, inset: inset)
        case .arrow:
            setupLayouts(width: width, height: height, inset: inset)
        }
        
    }
    // MARK: - Button Actions
    @objc private func buttonTapped() {
        buttonClicked()
    }
    
    // MARK: - SetupLayout
    
    func setupLayouts(width: CGFloat, height: CGFloat, inset: CGFloat) {
        
        imageView?.snp.makeConstraints({ (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(inset)
        })
        
        titleLabel?.snp.makeConstraints({ make in
            make.centerY.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(inset)
            make.width.equalTo(150)
        })
    }
    
    func setupCenterType(width: CGFloat, height: CGFloat, inset: CGFloat) {
        titleLabel?.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
    }
    
    func changeButtonStatus(isEnabled: Bool) {
        self.isButtonEnabled = isEnabled
        self.isEnabled = isEnabled
    }
   
    func setColor(color: UIColor?) {
        self.buttonColor = color
    }
}

