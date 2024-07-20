//
//  MessageCell.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 28/06/2024.
//

import UIKit

class MessageCell: UITableViewCell {
    
    //MARK: - Elements
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 20
        element.contentMode = .scaleToFill
        element.distribution = .fill
        element.alignment = .bottom
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var leftImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: K.youAvatar)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var rightImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: K.meAvatar)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var messageView: UIView = {
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var messageLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    //MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageView.frame = contentView.bounds
        
        messageView.layer.cornerRadius = (messageView.frame.height - 20) / 4
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Properties
    public func configure(with model: Message) {
        
        switch model.sender {
        case .me:
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        case .you:
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageView.backgroundColor = UIColor(named: K.BrandColors.purple)
            messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        messageLabel.text = model.body
    }
    
    
    
    
    
    //MARK: - Set Views
    private func setViews() {
        
        
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(leftImageView)
        mainStackView.addArrangedSubview(messageView)
        mainStackView.addArrangedSubview(rightImageView)
        messageView.addSubview(messageLabel)
        
       
    }
    
}

//MARK: - Setup Constraints
extension MessageCell {
    
    
    private func setConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
    }
    
    
}
