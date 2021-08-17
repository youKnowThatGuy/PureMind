//
//  ChatPresenter.swift
//  PureMind
//
//  Created by Клим on 06.08.2021.
//
import UIKit
import MessageKit

protocol ChatPresenterProtocol{
    init(view: ChatViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func getChatUser() -> Sender
    func getMessagesCount() -> Int
    func returnMessageByIndex(index: Int) -> Message
    func insertMessage(message: Message)
}

class ChatPresenter: ChatPresenterProtocol{
    weak var view: ChatViewProtocol?
    
    var messages = [MessageType]()
    let chatUser = Sender(senderId: "self", displayName: "Я")
    let chatBot = Sender(senderId: "bot", displayName: "PureMind")
    
    required init(view: ChatViewProtocol) {
        self.view = view
        messages.append(Message(sender: chatUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Мне не помешала бы помощь")))
        messages.append(Message(sender: chatBot,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-85400),
                                kind: .text("Чем я могу вам помочь?")))
        messages.append(Message(sender: chatUser,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(-85300),
                                kind: .text("Разве робот может написать симфонию?")))
        messages.append(Message(sender: chatBot,
                                messageId: "4",
                                sentDate: Date().addingTimeInterval(-84400),
                                kind: .text("Ну, наверное могу")))
        messages.append(Message(sender: chatUser,
                                messageId: "5",
                                sentDate: Date().addingTimeInterval(-26400),
                                kind: .text("Нет, не можешь")))
        messages.append(Message(sender: chatBot,
                                messageId: "6",
                                sentDate: Date().addingTimeInterval(-16400),
                                kind: .text("Блин(((((")))
    }
    
    func insertMessage(message: Message) {
        messages.append(message)
        view?.updateUI()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "chatSegue":
            guard let vc = segue.destination as? TherapistChoiceViewController
            else {fatalError("invalid data passed")}
            vc.presenter = TherapistChoicePresenter(view: vc)
            
        default:
            break
        }
    }
    
    func returnMessageByIndex(index: Int) -> Message {
        messages[index] as! Message
    }
    
    func getMessagesCount() -> Int {
        return self.messages.count
    }
    
    func getChatUser() -> Sender {
        return chatUser
    }
    
}
