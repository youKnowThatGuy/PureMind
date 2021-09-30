//
//  ChatViewController.swift
//  PureMind
//
//  Created by Клим on 06.08.2021.
//

import UIKit
import MessageKit
import InputBarAccessoryView


protocol ChatViewProtocol: UIViewController{
    func updateUI()
    func hideButtons()
    var multipleChoice: Bool {get set}
}

struct Sender: SenderType{
    var senderId: String
    var displayName: String
}

struct Message: MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    var presenter: ChatPresenterProtocol!
    let topView = UIView(frame: CGRect(x: 20, y: 20, width: 380, height: 35))
    var buttonTableView = UITableView(frame: CGRect(x: 29, y: 601, width: 305, height: 188), style: .plain)
    var multipleChoice = false
    var isTableViewHidden = false
    
    override func viewDidLoad() {
        prepareMessagesView()
        super.viewDidLoad()
        configureMessageInputBar()
        view.addSubview(topView)
        setupTopViewLayout()
        view.addSubview(buttonTableView)
        setupButtonCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.tabBarController?.tabBar.isHidden = true
    }
    
    func prepareMessagesView(){
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.contentInset.top = 90
        messagesCollectionView.contentInset.bottom = 100
        
        let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
        layout?.setMessageIncomingMessagePadding(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 80))
        layout?.setMessageOutgoingMessagePadding(UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 5))
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.placeholder = "Напишите сообщение..."
        messageInputBar.inputTextView.placeholderTextColor = grayTextColor
        messageInputBar.inputTextView.font = UIFont(name: "Montserrat-Regular", size: 16)
        messageInputBar.inputTextView.textColor = grayTextColor
        messageInputBar.middleContentView?.backgroundColor = .white
        messageInputBar.inputTextView.placeholderTextColor = grayTextColor
        messageInputBar.rightStackView.backgroundColor = lightYellowColor
        messageInputBar.sendButton.setTitle("", for: .normal)
        messageInputBar.sendButton.setImage(UIImage(named: "icon_google"), for: .normal)
        messageInputBar.backgroundView.backgroundColor = lightYellowColor
        messageInputBar.backgroundView.layer.cornerRadius = 15
    }

    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addTherapistPressed() {
    }
    
    @objc func chatHistoryPressed() {
        if isTableViewHidden == false{
            isTableViewHidden = true
            buttonTableView.isHidden = true
        }
        else{
            isTableViewHidden = false
            buttonTableView.isHidden = false
        }
    }
    
    private func setupButtonCollectionView(){
        buttonTableView.delegate = self
        buttonTableView.dataSource = self
        buttonTableView.backgroundColor = UIColor(white: 1, alpha: 0)
        buttonTableView.register(UINib(nibName: "ButtonViewCell", bundle: nil), forCellReuseIdentifier: "ButtonCell")
        let margins = view.layoutMarginsGuide
        buttonTableView.translatesAutoresizingMaskIntoConstraints = false
        buttonTableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 635).isActive = true
        buttonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        buttonTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.152019).isActive = true
        buttonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true //right
        buttonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true //left
        buttonTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonTableView.showsVerticalScrollIndicator = false
        buttonTableView.alwaysBounceVertical = false
        buttonTableView.separatorColor = .clear
    }
    
    private func setupTopViewLayout() {
        let margins = view.layoutMarginsGuide
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        topView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -592).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.0773207).isActive = true
        
        //pieChart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //pieChart.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true //right
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true //left
        
        let backButton = UIButton(frame: CGRect(x: 8, y: 8.5, width: 39, height: 36))
        backButton.setTitle("", for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "chevron.left.circle"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.tintColor = lightYellowColor
        topView.addSubview(backButton)
        
        let therapistButton = UIButton(frame: CGRect(x: 89, y: 13, width: 161, height: 29))
        therapistButton.setTitle("Добавить терапевта", for: .normal)
        therapistButton.titleLabel?.font = .systemFont(ofSize: 14)
        therapistButton.backgroundColor = .gray
        therapistButton.addTarget(self, action: #selector(addTherapistPressed), for: .touchUpInside)
        topView.addSubview(therapistButton)
        
        let historyButton = UIButton(frame: CGRect(x: 292, y: 13, width: 80, height: 29))
        historyButton.setTitle("История", for: .normal)
        historyButton.backgroundColor = .gray
        historyButton.titleLabel?.font = .systemFont(ofSize: 14)
        historyButton.addTarget(self, action: #selector(chatHistoryPressed), for: .touchUpInside)
        topView.addSubview(historyButton)
    }
    
    //-MARK: MESSAGES Delegates
    func currentSender() -> SenderType {
        return presenter.getChatUser()
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        presenter.returnMessageByIndex(index: indexPath.section)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        presenter.getMessagesCount()
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : grayTextColor
        }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
            return isFromCurrentSender(message: message) ? lightYellowColor : UIColor(red: 233, green: 241, blue: 254)
        }
    
    func scrollDown(){
    DispatchQueue.main.async {
        self.messagesCollectionView.scrollToItem(at: IndexPath(row: 0, section: self.presenter.getMessagesCount() - 1), at: .top, animated: false)
       }
    }
    
    }


extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getButtonsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonViewCell.identifier) as? ButtonViewCell
        else {fatalError("invalid cell kind")}
        presenter.prepareCell(prepare: cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if multipleChoice == true && indexPath.row < 6{
            presenter.manageMultipleAnswers(index: indexPath.row)
        }
        else{
            presenter.getResponse(for: indexPath.row)
        }
    }
}

extension ChatViewController: ChatViewProtocol{
    func updateUI() {
        messagesCollectionView.reloadData()
        buttonTableView.reloadData()
        scrollDown()
    }
    
    func hideButtons(){
        buttonTableView.isHidden = true
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate{
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
            processInputBar(messageInputBar)
        }

        func processInputBar(_ inputBar: InputBarAccessoryView) {
            // Here we can parse for which substrings were autocompleted
            let attributedText = inputBar.inputTextView.attributedText!
            let range = NSRange(location: 0, length: attributedText.length)
            attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in

                let substring = attributedText.attributedSubstring(from: range)
                let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
                print("Autocompleted: `", substring, "` with context: ", context ?? [])
            }

            let components = inputBar.inputTextView.components
            inputBar.inputTextView.text = String()
            inputBar.invalidatePlugins()
            // Send button activity animation
            inputBar.sendButton.startAnimating()
            inputBar.inputTextView.placeholder = "Отправляю..."
            // Resign first responder for iPad split view
            inputBar.inputTextView.resignFirstResponder()
            DispatchQueue.global(qos: .default).async {
                // fake send request task
                sleep(1)
                DispatchQueue.main.async { [weak self] in
                    inputBar.sendButton.stopAnimating()
                    inputBar.inputTextView.placeholder = "Напишите сообщение..."
                    self?.insertMessages(components)
                    self?.messagesCollectionView.scrollToLastItem(animated: true)
                }
            }
        }
    
        private func insertMessages(_ data: [Any]) {
            for component in data {
                let user = presenter.getChatUser()
                if let str = component as? String {
                    let message = Message(sender: user, messageId: UUID().uuidString, sentDate: Date(), kind: .text(str))
                    presenter.insertMessage(message: message)
                }
            }
        }
}
