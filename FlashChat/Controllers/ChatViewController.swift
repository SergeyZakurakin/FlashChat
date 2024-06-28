//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 27/06/2024.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    
    //MARK: - UI
    
    private let tableView = UITableView()
    
    private lazy var containerView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var messageTextField: UITextField = {
        let element = UITextField()
        element.backgroundColor = .white
        element.borderStyle = .roundedRect
        element.placeholder = Constants.enterMessagePlaceholder
        element.textColor = UIColor(named: Constants.BrandColors.purple)
        element.tintColor = UIColor(named: Constants.BrandColors.purple)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var enterButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: Constants.enterButtonImageName), for: .normal)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Private Properties
    
    private let messages = Message.getMessages()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        setViews()
        setConstraints()
        setDelegates()
    }
    
    
    
    //MARK: - setup Views
    private func setViews() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        navigationController?.navigationBar.barTintColor = UIColor(named: Constants.BrandColors.blue)
        
        view.backgroundColor = UIColor(named: Constants.BrandColors.purple)
        title = Constants.appName
        
        view.addSubview(tableView)
        view.addSubview(containerView)
        
        containerView.addSubview(messageTextField)
        containerView.addSubview(enterButton)
//        view.addSubview(messageTextField)
        
        
        
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        let model = messages[indexPath.row]
        cell.textLabel?.text = model.body
        
        return cell
    }
    
    
}

//MARK: - Setup Constraints
extension ChatViewController {
    
    private func setConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(containerView.snp.top)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        messageTextField.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(messageTextField.snp.trailing).offset(20)
            make.height.width.equalTo(40)
        }
    }
    
}
