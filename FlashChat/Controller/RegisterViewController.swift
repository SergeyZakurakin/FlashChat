//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 26/06/2024.
//

import UIKit
import SnapKit

enum Autorisation: String {
    case register = "Register"
    case login = "Log in"
}

final class RegisterViewController: UIViewController {

    //MARK: - UI
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 8
        
        return element
    }()
    
    let emailTextField = UITextField(
        placeholder: Constants.emailName,
        color: UIColor(named: Constants.BrandColors.blue)
    )
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: Constants.textfieldImageName)
        
        return element
    }()
    
    private let passwordTextField = UITextField(
        placeholder: Constants.passwordName,
        color: .black
    )
    
    let registerButton = UIButton(titleColor: UIColor(named: Constants.BrandColors.blue))
    
    //MARK: - Public Properties
    
    public var autorizationType: Autorisation?

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        
    }
    //MARK: - Set Views
    private func setViews() {
        navigationController?.navigationBar.tintColor = .systemYellow
        
        switch autorizationType {
        case .register:
            view.backgroundColor = UIColor(named: Constants.BrandColors.lightBlue)
            registerButton.setTitle(Constants.registerName, for: .normal)
        case .login:
            view.backgroundColor = UIColor(named: Constants.BrandColors.blue)
            registerButton.setTitle(Constants.logInName, for: .normal)
            registerButton.setTitleColor(.white, for: .normal)
            
            emailTextField.text = "1@1.com"
        default:
            break
        }
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(registerButton)
        imageView.addSubview(passwordTextField)
        
        emailTextField.makeShadow()
    }
    
  
    
    
    
    
//    @objc private func buttonsPressed(_ sender: UIButton) {
//        
//    }
}


//MARK: - Setup Constraints
extension RegisterViewController {
    
    // use SnapKit for Constraint
    private func setConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalTo(view).inset(36)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(137)
            make.leading.trailing.equalTo(view)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-62)
            make.leading.trailing.equalToSuperview().inset(48)
            make.height.equalTo(45)
        }
        
    }
}
//MARK: - UIView
extension UIView {
    // shadow
    func makeShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .init(width: 0, height: 10)
        self.layer.shadowRadius = 10
    }
    
}

//MARK: - UITextField
extension UITextField {
    convenience init (placeholder: String, color: UIColor?) {
        self.init()
        
        self.placeholder = placeholder
        self.textAlignment = .center
        self.textColor = color
        self.backgroundColor = .white
        self.layer.cornerRadius = 30
        self.font = .systemFont(ofSize: 25)
        self.tintColor = color
    }
}
