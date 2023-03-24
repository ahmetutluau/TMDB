//
//  LoginVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 21.03.2023.
//

import UIKit

class LoginVC: BaseVC {
    let viewModel = LoginVM()
    
    private lazy var backgroundImageView: BaseImageView = {
        let view = BaseImageView(image: UIImage(named: "loginBackground2"),
                                 contentMode: .scaleAspectFill,
                                 backgroundColor: .clear)
                
        return view
    }()
    
    private lazy var titleLabel: BaseLabel = {
        let label = BaseLabel(text: .plain("MovieDB"),
                            textAlignment: .left,
                            numberOfLines: 1,
                            textColor: UIColor.white,
                              font: .systemFont(ofSize: 34, weight: .bold),
                            backgroundColor: UIColor.clear)
        return label
    }()
    
    private lazy var usernameTextField: CommonTextField = {
        let textField = CommonTextField(frame: .zero)
        
        textField.placeholder = "Username"
        textField.textAlignment = .left
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 18, weight: .bold)
        textField.backgroundColor = .clear
        textField.tintColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = CGFloat.dHeight * 30/812
        textField.addLeftPadding(CGFloat.dWidth * 20/375)
        textField.addRightPadding(CGFloat.dWidth * 20/375)
        
        textField.textFieldDidEndEditing =  { [weak self] textfield, text in
            guard let self = self else { return }
            
            self.viewModel.dataSource.username = text
        }
        
        textField.textFieldShouldReturn = {[weak self] textfield in
            guard let self = self else { return }
            
            if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        return textField
    }()
    
    private lazy var passwordTextField: CommonTextField = {
        let textField = CommonTextField(frame: .zero)
        
        textField.placeholder = "Password"
        textField.textAlignment = .left
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 18, weight: .bold)
        textField.backgroundColor = .clear
        textField.tintColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = CGFloat.dHeight * 30/812
        textField.addLeftPadding(CGFloat.dWidth * 20/375)
        textField.addRightPadding(CGFloat.dWidth * 45/375)
        textField.isSecureTextEntry = true
        
        
        textField.textFieldDidChange =  { [weak self] text in
            guard let self = self else { return }
            
            self.viewModel.dataSource.password = text
        }
        
        textField.textFieldShouldReturn = {[weak self] textfield in
            guard let self = self else { return }
            
            if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }

        return textField
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.setImage(UIImage(systemName: "eye.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(tappedShowPasswordButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signupContainerView: BaseView = {
        let view = BaseView(backgroundColor: .clear)
        
        return view
    }()
    
    private lazy var signupLabel: BaseLabel = {
        let label = BaseLabel(text: .plain("Don't have an account?"),
                              textAlignment: .left,
                              numberOfLines: 1,
                              textColor: UIColor.white,
                              font: .systemFont(ofSize: 14, weight: .regular),
                              backgroundColor: .clear)
        return label
    }()
    
    private lazy var signupButton: CustomButton = {
        let button = CustomButton(type: .center,
                                  title: "Sign up",
                                  font: .systemFont(ofSize: 14, weight: .bold),
                                  titleColor: UIColor.white,
                                  backgroundColor: .clear,
                                  cornerRadius: 0,
                                  underLineStyle: true)
        
        button.changeButtonStatus(isEnabled: true)
        button.addTarget(self, action: #selector(tappedSignupButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var continueButton: CustomButton = {
        let button = CustomButton(type: .center,
                                  title: "Login",
                                  font: .systemFont(ofSize: 20, weight: .bold),
                                  titleColor: .white,
                                  backgroundColor: .systemGray,
                                  cornerRadius: CGFloat.dHeight * (30/812),
                                  isCenteredTitle: true)
        
        button.setColor(color: ThemeColors.buttoncolor.color)
        button.isButtonEnabled = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColors.background3.color
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews([backgroundImageView,
                          titleLabel,
                          usernameTextField,
                          passwordTextField,
                          showPasswordButton,
                          signupContainerView,
                          continueButton])
        
        signupContainerView.addSubviews([signupLabel,
                                        signupButton])
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.dHeight * 50/812)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(CGFloat.dHeight/3)
        }
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(CGFloat.dHeight * 50/812)
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 30/375)
            make.height.equalTo(CGFloat.dHeight * 60/812)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 30/375)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(CGFloat.dHeight * 30/812)
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 30/375)
            make.height.equalTo(CGFloat.dHeight * 60/812)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 30/375)
        }
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 50/375)
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.width.equalTo(CGFloat.dWidth * 20/375)
            make.height.equalTo(CGFloat.dHeight * 6/375)
        }
        signupContainerView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(CGFloat.dHeight * 10/812)
            make.centerX.equalToSuperview()
        }
        signupLabel.snp.makeConstraints { make in
            make.bottom.top.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        signupButton.snp.makeConstraints { make in
            make.leading.equalTo(signupLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.trailing.bottom.top.equalToSuperview()
        }
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-CGFloat.dHeight * 100/812)
            make.leading.equalToSuperview().offset(CGFloat.dWidth * 30/375)
            make.height.equalTo(CGFloat.dHeight * 64/812)
            make.trailing.equalToSuperview().offset(-CGFloat.dWidth * 30/375)
        }
    }
    
    @objc private func buttonTapped() {
        self.viewModel.createToken()
    }
    
    @objc private func tappedShowPasswordButton() {
        self.passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc private func tappedSignupButton() {
        guard let URL = URL(string: "https://www.themoviedb.org/signup") else { return }
        if UIApplication.shared.canOpenURL(URL) {
            DispatchQueue.main.async {
                let vc = WebViewVC()
                vc.urlString = "https://www.themoviedb.org/signup"
                self.present(vc, animated: true)
            }
        } else {
            RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: "Webview can't open.", firstButtonTitle: "Tamam")
        }
    }
}


extension LoginVC {
    override func observeViewModel() {
        super.observeViewModel()
        
        self.viewModel.subscribe { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .LoginSuccess:
                let vc = HomeVC()
                self.setViewController(as: vc)
            case .networkFailure(let message):
                RedirectManager.shared.showAlert(from: self, title: "Uyarı", message: message, firstButtonTitle: "Tamam")
            }
        }
    }
}
