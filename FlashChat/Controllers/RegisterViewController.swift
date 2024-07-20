//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 26/06/2024.
//

import UIKit
import SnapKit
import FirebaseAuth

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
        placeholder: K.emailName,
        color: UIColor(named: K.BrandColors.blue)
    )
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.isUserInteractionEnabled = true
        element.image = UIImage(named: K.textfieldImageName)
        
        return element
    }()
    
    private let passwordTextField = UITextField(
        placeholder: K.passwordName,
        color: .black
    )
    
    let registerButton = UIButton(titleColor: UIColor(named: K.BrandColors.blue))
    
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
            view.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
            registerButton.setTitle(K.registerName, for: .normal)
            
        case .login:
            view.backgroundColor = UIColor(named: K.BrandColors.blue)
            registerButton.setTitle(K.logInName, for: .normal)
            registerButton.setTitleColor(.white, for: .normal)
            
            emailTextField.text = "1@2.com"
            passwordTextField.text = "123456"
        default:
            break
        }
        
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(registerButton)
        imageView.addSubview(passwordTextField)
        
        emailTextField.makeShadow()
        
        registerButton.addTarget(self, action: #selector(buttonsPressed), for: .touchUpInside)
        
        passwordTextField.isSecureTextEntry = true
    }
    
    
    @objc private func buttonsPressed(_ sender: UIButton) {
        if sender.currentTitle == K.logInName {
            
            guard let email = emailTextField.text else {return}
            guard let password = passwordTextField.text else {return}
            
            Auth.auth().signIn(
                withEmail: email,
                password: password
            ) { authResult, error in
                if let error {
                    print(error)
                    // create Alert
                } else {
                    
                    let chatVC = ChatViewController()
                    self.navigationController?.pushViewController(chatVC, animated: true)
                }
            }
            
            
        } else {
            
            guard let email = emailTextField.text else {return}
            guard let password = passwordTextField.text else {return}
            
            //вынести отдельно
            Auth.auth().createUser(
                withEmail: email,
                password: password
            ) { authResult, error in
                if let error {
                    print(error.localizedDescription)
                    // create Alert
                }
                
                let chatVC = ChatViewController()
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
            print("register")
        }
    }
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



