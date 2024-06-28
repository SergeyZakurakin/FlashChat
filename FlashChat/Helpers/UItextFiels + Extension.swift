//
//  textFiels + extension.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 27/06/2024.
//

import UIKit

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
