//
//  TextExcercisePresenter.swift
//  PureMind
//
//  Created by Клим on 12.10.2021.
//

import Foundation

protocol TextExcercisePresenterProtocol{
    init(view: TextExcerciseViewProtocol, currAudio: String?, id: String)
    func loadAudio()
    func sendText(userText: String)
}

class TextExcercisePresenter: TextExcercisePresenterProtocol{
    
    weak var view: TextExcerciseViewProtocol?
    var url: String?
    var excId: String!
    
    required init(view: TextExcerciseViewProtocol, currAudio: String?, id: String) {
        self.view = view
        excId = id
        if currAudio != nil{
            url = currAudio!
        }
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
                self?.view?.sendAlert(text: "Ваш ответ записан.")
            }
        }
    }
    
}
