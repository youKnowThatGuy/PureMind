//
//  GapsExcercisePresenter.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import UIKit

protocol GapsExcercisePresenterProtocol{
    init(view: GapsExcerciseViewProtocol, currAudio: String?, currCode: String, id: String)
    func getGapsCount() -> Int
    func prepareCell(cell: GapTableViewCell, index: Int)
    func updateAnswers(answer: String, cellIndex: Int)
    func loadAudio()
    func sendText(userText: String)
}

class GapsExcercisePresenter: GapsExcercisePresenterProtocol{
    weak var view: GapsExcerciseViewProtocol?
    var url: String?
    var excId: String!
    var currGapsText = [String]()
    var currCode: String!
    var answers = [String]()
    required init(view: GapsExcerciseViewProtocol, currAudio: String?, currCode: String, id: String) {
        self.view = view
        excId = id
        if currAudio != nil{
            url = currAudio!
        }
        self.currCode = currCode
        setGapsText()

    }
    
    func loadAudio(){
        if url != nil{
            NetworkService.shared.getAudio(audioId: url!) {[weak self] (result) in
                switch result{
                case .failure(_):
                    self?.view?.sendAlert(text: "Не удалось загрузить аудио")
                case let .success(data):
                    self?.view?.updateUI(audioData: data)
                }
            }
        }
        else{
            view?.sendAlert(text: "Не удалось загрузить аудио")
        }
    }
    
    func sendText(userText: String){
        NetworkService.shared.sendExcerciseAnswer(excerciseId: excId, selectionAnswers: [], customAnswer: userText) {[weak self] (result) in
            switch result{
            case .failure(_):
                self?.view?.sendAlert(text: "Не удалось отправить ответ")
            case .success(_):
                self?.view?.sendAlert(text: "Успешно!")
            }
        }
    }
    
    func setGapsText(){
        switch currCode {
        case "01":
            currGapsText = ["Здравствуй мой страх (какой? страх чего?).", "Ты называешься ____ (назови его по имени).", "Когда ты присутствуешь, я чувствую ____.", "Страх, ты говоришь мне о том, что ____.", "И даешь мне понять, что ____ .", "Страх, ты обращаешь мое внимание на ____.", "И освобождаешь меня от следующей нежелательной деятельности: ____ (перечислить).", "Страх, ты полезен для меня тем, что ____.", "Ты исполняешь роль ____.", "Страх, ты относишься к сфере ____.", "Страх, ты — как способность ____, которую я хочу развить. (назвать способность)", "Страх, я благодарю тебя за ____.", "Страх, ты дал мне возможность ____.", "Страх, я хочу ____."]
            answers = Array(repeating: "", count: currGapsText.count)
        case "12":
            currGapsText = ["Когда ты видишь свое отражение ____", "Когда ты совершаешь ошибку ____", "Когда тебя вызывают по какому-то делу на работу _____", "Когда кто-то другой оскорбляет тебя ____", "Когда тебе плохо ____", "Когда вы поддаетесь искушениям или возвращаетесь к старым привычкам ____"]
            answers = Array(repeating: "", count: currGapsText.count)
        case "21":
            answers = Array(repeating: "", count: 5)
        case "31":
            answers = Array(repeating: "", count: 10)

        default:
            break
        }
    }
    
    func updateAnswers(answer: String, cellIndex: Int){
        answers[cellIndex] = answer
    }
    
    func getGapsCount() -> Int {
        switch currCode {
        case "01", "12":
            return currGapsText.count
        case "21":
            return 5
        case "31":
            return 10
        default:
            return 0
        }
    }
    
    func prepareCell(cell: GapTableViewCell, index: Int){
        cell.parentPresenter = self
        cell.index = index
        cell.answerField.text = answers[index]
        switch currCode {
        case "01", "12":
            cell.textPartLabel.text = currGapsText[index]
        case "21", "31":
            cell.textPartLabel.text = "\(index + 1)."
        default:
            break
        }
    }
    
}
