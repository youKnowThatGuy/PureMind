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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMessagesView()
        configureMessageInputBar()
        view.addSubview(topView)
        setupTopViewLayout()
    }
    
    func prepareMessagesView(){
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.contentInset.top = 90
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
    }

    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addTherapistPressed() {
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
        
        let backButton = UIButton(frame: CGRect(x: 8, y: 8.5, width: 39, height: 36))
        backButton.setTitle("", for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "chevron.left.circle"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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
    
    
    //-MARK: MESSAGES FUNCTIONS
    func currentSender() -> SenderType {
        return presenter.getChatUser()
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        presenter.returnMessageByIndex(index: indexPath.section)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        presenter.getMessagesCount()
    }
    
    
}

extension ChatViewController: ChatViewProtocol{
    func updateUI() {
        messagesCollectionView.reloadData()
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
            inputBar.inputTextView.placeholder = "Sending..."
            // Resign first responder for iPad split view
            inputBar.inputTextView.resignFirstResponder()
            DispatchQueue.global(qos: .default).async {
                // fake send request task
                sleep(1)
                DispatchQueue.main.async { [weak self] in
                    inputBar.sendButton.stopAnimating()
                    inputBar.inputTextView.placeholder = "Aa"
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
