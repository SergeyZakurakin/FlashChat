//
//  UIButton + Extension.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 27/06/2024.
//

import UIKit

extension UIButton {
    convenience init (titleColor: UIColor?, backgroundColor: UIColor? = .clear) {
        self.init(type: .system)
            
        self.titleLabel?.font = .systemFont(ofSize: 30)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        
    }
}
