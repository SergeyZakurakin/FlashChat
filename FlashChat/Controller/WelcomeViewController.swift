//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 26/06/2024.
//

import UIKit
import SnapKit

final class WelcomeViewController: UIViewController {

    //MARK: - UI
private lazy var titleLabel: UILabel = {
    let element = UILabel()
    element.textColor = UIColor(named: Constants.BrandColors.blue)
    element.font = .systemFont(ofSize: 50, weight: .black)
    
    element.translatesAutoresizingMaskIntoConstraints = false
    return element
}()
    
    
    let registerButton = UIButton(
        titleColor: UIColor(named: Constants.BrandColors.blue),
        backgroundColor: UIColor(named: Constants.BrandColors.lightBlue)
    )
    
    let loginButton = UIButton(
        titleColor: .white,
        backgroundColor: .systemTeal
    )
    

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraint()
        
    }
    
    //MARK: - Set Views
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        
        
        titleLabel.text = Constants.appName
        registerButton.setTitle(Constants.registerName, for: .normal)
        loginButton.setTitle(Constants.logInName, for: .normal)
        
        registerButton.addTarget(self, action: #selector(buttonsPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(buttonsPressed), for: .touchUpInside)
    }
    
    
    //MARK: - Private Methods
    @objc private func buttonsPressed(_ sender: UIButton) {
        let nextVC = RegisterViewController()
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}


//MARK: - Setup Constraints
extension WelcomeViewController {
    
    // use SnapKit for Constraint
    private func setConstraint() {
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Size.buttonSize)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Size.buttonSize)
            make.bottom.equalTo(loginButton.snp.top).offset(-Constants.Size.buttonOffset)
        }
    }
}


extension UIButton {
    convenience init (titleColor: UIColor?, backgroundColor: UIColor? = .clear) {
        self.init(type: .system)
            
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        
    }
}
