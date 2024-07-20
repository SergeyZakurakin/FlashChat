//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 27/06/2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    //MARK: - UI
    
    private let tableView = UITableView()
    
    private lazy var containerView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: K.BrandColors.purple)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var messageTextField: UITextField = {
        let element = UITextField()
        element.backgroundColor = .white
        element.borderStyle = .roundedRect
        element.placeholder = K.enterMessagePlaceholder
        element.textColor = UIColor(named: K.BrandColors.purple)
        element.tintColor = UIColor(named: K.BrandColors.purple)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var enterButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: K.enterButtonImageName), for: .normal)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Private Properties
    
    private var messages = Message.getMessages()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        setViews()
        setConstraints()
        setDelegates()
        setupLogOutButton()
    }
    
    private func setupLogOutButton() {
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonPressed))
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    
    
    //MARK: - setup Views
    private func setViews() {
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: K.cellIdentifier)
        tableView.separatorStyle = .none
        
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.blue)
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        title = K.appName
        
        view.addSubview(tableView)
        view.addSubview(containerView)
        
        containerView.addSubview(messageTextField)
        containerView.addSubview(enterButton)
//        view.addSubview(messageTextField)
        
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    
    //MARK: - Actions
    @objc private func enterButtonPressed() {
        if let text = messageTextField.text, !text.isEmpty{
            messages.append(Message(sender: .me, body: text))
            messageTextField.text = ""
            tableView.reloadData()
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    @objc private func logOutButtonPressed() {
        print("Log Out")
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MessageCell else { fatalError() }
        
        let model = messages[indexPath.row]
        cell.configure(with: model)
        
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
