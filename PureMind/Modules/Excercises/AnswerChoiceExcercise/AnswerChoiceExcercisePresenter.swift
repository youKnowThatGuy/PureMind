//
//  AnswerChoiceExcercisePresenter.swift
//  PureMind
//
//  Created by Клим on 21.01.2022.
//

import UIKit

protocol AnswerChoiceExcercisePresenterProtocol{
    init(view: AnswerChoiceExcerciseViewProtocol, currAudio: String?, id: String, roughAnswers: [ExcerciseAnswer])
    func prepareCell(cell: ExcerciseAnswerViewCell, index: Int)
    func manageAnswer(index: Int)
    func loadAudio()
    func getNumberOfItems() -> Int
}

class AnswerChoiceExcercisePresenter: AnswerChoiceExcercisePresenterProtocol{
    
    weak var view: AnswerChoiceExcerciseViewProtocol?
    var url: String?
    var excId: String!
    var data = [ExcerciseAnswer]()
    
    required init(view: AnswerChoiceExcerciseViewProtocol, currAudio: String?, id: String, roughAnswers: [ExcerciseAnswer]) {
        self.view = view
        excId = id
        data = roughAnswers
        if currAudio != nil{
            url = currAudio!
        }
    }
    
    func manageAnswer(index: Int) {
        NetworkService.shared.sendExcerciseAnswer(excerciseId: excId, selectionAnswers: [data[index].id], customAnswer: "") {[weak self] (result) in
            switch result{
            case .failure(_):
                self?.view?.sendAlert(text: "Не удалось отправить ответ")
            case .success(_):
                self?.view?.sendAlert(text: "Успешно!")
            }
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
    
    func getNumberOfItems() -> Int {
        return data.count
    }
    
    func prepareCell(cell: ExcerciseAnswerViewCell, index: Int){
        cell.textView.textColor = grayTextColor
        cell.layer.borderColor = lightBlueColor.cgColor
        cell.layer.borderWidth = 2
        cell.choiceButtonShell.setTitleColor(.white, for: .normal)
        cell.choiceButtonShell.layer.backgroundColor = lightBlueColor.cgColor
        cell.choiceButtonShell.layer.cornerRadius = 15
        cell.index = index
        cell.parentPresenter = self
        cell.textView.text = data[index].text
        }
    
}
