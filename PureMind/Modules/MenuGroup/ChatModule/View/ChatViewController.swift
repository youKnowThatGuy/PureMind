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
    //var buttonTableView = UITableView(frame: CGRect(x: 29, y: 601, width: 305, height: 188), style: .plain)
    
    override func viewDidLoad() {
        prepareMessagesView()
        super.viewDidLoad()
        configureMessageInputBar()
        view.addSubview(topView)
        setupTopViewLayout()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        //view.addSubview(buttonTableView)
        //setupButtonCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
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
        messageInputBar.sendButton.setImage(UIImage(named: "send_button"), for: .normal)
        messageInputBar.backgroundView.backgroundColor = lightYellowColor
        messageInputBar.backgroundView.layer.cornerRadius = 15
    }

    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addTherapistPressed() {
    
    }
    
    @objc func openReactionVC() {
        guard let reactionVC = storyboard?.instantiateViewController(withIdentifier: "ReactionViewController")
          as? ReactionViewController else {
              fatalError("No view controller found")
          }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 , execute: {
            reactionVC.backingImage = self.tabBarController?.view.asImage()
            self.presenter.prepareVC(viewController: reactionVC)
            self.navigationController?.pushViewController(reactionVC, animated: false)
          })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
    @objc func chatHistoryPressed() {
        
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
        
        let backButton = UIButton(frame: CGRect(x: 20, y: 8.5, width: 35, height: 35))
        backButton.setTitle("", for: .normal)
        backButton.setBackgroundImage(UIImage(named: "backButtonYellow"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        topView.addSubview(backButton)
        
        let therapistButton = UIButton(frame: CGRect(x: 109, y: 13, width: 161, height: 29))
        therapistButton.setTitle("Добавить терапевта", for: .normal)
        therapistButton.titleLabel?.font = .systemFont(ofSize: 16)
        therapistButton.titleLabel?.textColor = .white
        therapistButton.layer.cornerRadius = 15
        therapistButton.backgroundColor = UIColor(red: 198, green: 222, blue: 255)
        therapistButton.addTarget(self, action: #selector(addTherapistPressed), for: .touchUpInside)
        //topView.addSubview(therapistButton)
        
        let historyButton = UIButton(frame: CGRect(x: 292, y: 13, width: 80, height: 29))
        historyButton.setTitle("История", for: .normal)
        historyButton.backgroundColor = .gray
        historyButton.titleLabel?.font = .systemFont(ofSize: 14)
        historyButton.addTarget(self, action: #selector(chatHistoryPressed), for: .touchUpInside)
        //topView.addSubview(historyButton)
        
        let openButtonViewButton = UIButton(frame: CGRect(x: 330, y: 683, width: 50, height: 50))
        openButtonViewButton.setBackgroundImage(UIImage(systemName: "message.circle"), for: .normal)
        openButtonViewButton.addTarget(self, action: #selector(openReactionVC), for: .touchUpInside)
        openButtonViewButton.tintColor = lightYellowColor
        view.addSubview(openButtonViewButton)
        openButtonViewButton.translatesAutoresizingMaskIntoConstraints = false
        openButtonViewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -81).isActive = true
        openButtonViewButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.0593824).isActive = true
        openButtonViewButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.120773).isActive = true
        openButtonViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
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

extension ChatViewController: ChatViewProtocol{
    func updateUI() {
        messagesCollectionView.reloadData()
        scrollDown()
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
