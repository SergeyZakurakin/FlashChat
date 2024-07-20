//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Sergey Zakurakin on 27/06/2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    //MARK: - properties
    
    
    
    
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
    
    private var messages: [Message] = []
    let db = Firestore.firestore()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        
        setViews()
        setConstraints()
        setDelegates()
        setupLogOutButton()
        loadMassages()
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
    
    private func loadMassages() {
     
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let self else { return }
                self.messages = []
                
                if let error {
                    print("There was an issue retrieving data from Firesstore. \(error)")
                } else {
                    guard let snaphotDocuments = querySnapshot?.documents else {return}
                    
                    for doc in snaphotDocuments {
                        let data = doc.data()
                        guard let sender = data[K.FStore.senderField] as? String,
                              let messageBody = data[K.FStore.senderField] as? String else {return}
                        
                        self.messages.append(Message(sender: sender, body: messageBody))
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                }
            }
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    
    //MARK: - Actions
    @objc private func enterButtonPressed() {
        
        guard let messageBody = messageTextField.text,
              let messageSender = Auth.auth().currentUser?.email else {return}
        
        db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Successfully saved data")
            }
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
        cell = mode
        
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
