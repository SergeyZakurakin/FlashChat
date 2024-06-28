//
//  UIView + Extension.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 27/06/2024.
//

import UIKit

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
