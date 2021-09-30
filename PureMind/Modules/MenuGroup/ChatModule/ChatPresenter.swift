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
    func prepareCell(prepare cell: ButtonViewCell, for index: Int)
    func getChatUser() -> Sender
    func getMessagesCount() -> Int
    func getButtonsCount() -> Int
    func getResponse(for index: Int)
    func manageMultipleAnswers(index: Int)
    func returnMessageByIndex(index: Int) -> Message
    func isButtonSelected(index: Int) -> Bool
    func insertMessage(message: Message)
}

class ChatPresenter: ChatPresenterProtocol{
    weak var view: ChatViewProtocol?
    
    var messages = [MessageType]()
    var buttons = ["Хочу проанализировать своё состояние", "Упражнения", "Переключение на специалиста"]
    var currMessages = [String]()
    var currUserMessage = ""
    var selectedMultipleAnswers = [String]()
    var textInputRequired = false
    let chatUser = Sender(senderId: "self", displayName: "Я")
    let chatBotProxy = Sender(senderId: "bot", displayName: "PureMind")
    let algorythm = ChatBot()
    
    
    required init(view: ChatViewProtocol) {
        self.view = view
        _ = Timer.scheduledTimer(
            timeInterval: 2.0, target: self, selector: #selector(sayHello),
            userInfo: nil, repeats: false)
    }
    
    
    @objc func sayHello(){
        messages.append(Message(sender: chatBotProxy,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(0),
                                kind: .text(algorythm.helloMessage)))
        view?.updateUI()
    }
    
    @objc func botSays(){
        messages.append(Message(sender: chatBotProxy,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(0),
                                kind: .text(currMessages.first!)))
        currMessages.removeFirst()
        view?.updateUI()
    }
    
    @objc func userSays(){
        messages.append(Message(sender: chatUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(0),
                                kind: .text(currUserMessage)))
        currUserMessage = ""
        view?.updateUI()
    }
    
    func insertMessage(message: Message) {
        messages.append(message)
        view?.updateUI()
        if textInputRequired == true{
            getResponse(for: 501)
            textInputRequired = false
        }
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
    
    func manageMultipleAnswers(index: Int) {
        let answer = buttons[index]
        if selectedMultipleAnswers.contains(answer){
            let index = selectedMultipleAnswers.firstIndex(of: answer)!
            selectedMultipleAnswers.remove(at: index)
        }
        else{
            selectedMultipleAnswers.append(answer)
        }
        view?.updateUI()
    }
    
    func returnMessageByIndex(index: Int) -> Message {
        messages[index] as! Message
    }
    
    func insertNewResponses(responses: [String], count: Int, for user: String){
        for i in 1...count{
            switch user {
            case "user":
                currUserMessage = responses[0]
                _ = Timer.scheduledTimer(
                    timeInterval: 0.5 + Double(i), target: self, selector: #selector(userSays),
                    userInfo: nil, repeats: false)
            case "bot":
                currMessages.append(responses[i])
                _ = Timer.scheduledTimer(
                    timeInterval: 0.5 + Double(i), target: self, selector: #selector(botSays),
                    userInfo: nil, repeats: false)
            default:
                break
            }
        }
    }
    
    func getResponse(for index: Int) {
        if (view?.multipleChoice == false || index >= 6) && index != 501{
            insertNewResponses(responses: [buttons[index], buttons[index]], count: 1, for: "user")
        }
        algorythm.path.append(index)
        let response = algorythm.botResponse()
        switch response[0] {
        case "1":
            insertNewResponses(responses: response, count: 1, for: "bot")
            buttons = []
            for i in 2..<response.count{
                buttons.append(response[i])
            }
            view?.updateUI()
            view?.multipleChoice = false
        case "2":
            insertNewResponses(responses: response, count: 2, for: "bot")
            buttons = []
            for j in 3..<response.count{
                buttons.append(response[j])
            }
            view?.updateUI()
            view?.multipleChoice = false
        case "3":
            insertNewResponses(responses: response, count: 3, for: "bot")
            buttons = []
            for j in 4..<response.count{
                buttons.append(response[j])
            }
            view?.updateUI()
            view?.multipleChoice = false
        case "5":
            insertNewResponses(responses: response, count: 5, for: "bot")
            buttons = []
            for j in 6..<response.count{
                buttons.append(response[j])
            }
            view?.updateUI()
            view?.multipleChoice = false
        case "specialist":
            messages.append(Message(sender: chatBotProxy,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-6400),
                                kind: .text(response[1])))
            buttons = []
            view?.updateUI()
            view?.hideButtons()
        case "textRequiered":
            insertNewResponses(responses: response, count: 2, for: "bot")
            buttons = []
            textInputRequired = true
            view?.updateUI()
        case "multi-sp":
            insertNewResponses(responses: response, count: 1, for: "bot")
            buttons = []
            for j in 2..<response.count{
                buttons.append(response[j])
            }
            view?.multipleChoice = true
            view?.updateUI()
        
        case "multi":
            insertNewResponses(responses: response, count: 1, for: "bot")
            buttons = []
            for j in 2..<response.count{
                buttons.append(response[j])
            }
            view?.multipleChoice = true
            view?.updateUI()
        default:
            break
        }
    }
    
    func prepareCell(prepare cell: ButtonViewCell, for index: Int){
        let buttonText = buttons[index]
        let check = selectedMultipleAnswers.firstIndex(of: buttonText)
        if check == nil{
            cell.unselectedView()
        }
        else{
            cell.selectedView()
        }
        cell.label.text = buttonText
    }
    
    func isButtonSelected(index: Int) -> Bool{
        let choice = buttons[index]
        return selectedMultipleAnswers.contains(choice)
    }
    
    func getMessagesCount() -> Int {
        return self.messages.count
    }
    
    func getButtonsCount() -> Int {
        return self.buttons.count
    }
    
    func getChatUser() -> Sender {
        return chatUser
    }
    
}
