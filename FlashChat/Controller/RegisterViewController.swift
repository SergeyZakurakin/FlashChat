//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 26/06/2024.
//

import UIKit
import SnapKit

final class RegisterViewController: UIViewController {

    //MARK: - UI
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 8
        
        element.backgroundColor = .lightGray
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraint()
        
    }
    
    //MARK: - Set Views
    private func setViews() {
        view.backgroundColor = .systemTeal
        
        view.addSubview(mainStackView)
        
    }
    
    
    @objc private func buttonsPressed(_ sender: UIButton) {
        
    }
}



//MARK: - Setup Constraints
extension RegisterViewController {
    
    // use SnapKit for Constraint
    private func setConstraint() {
        
//        mainStackView.snp
    }
    
}

extension UITextField {
    convenience init (placeholder: String, textColor: UIColor) {
        self.init()
        
        self.placeholder = placeholder
        self.textAlignment = .center
        self.textColor = textColor
        
        
        
        
        
        
    }
}
