//
//  MultipleChoiceDiaryPresenter.swift
//  PureMind
//
//  Created by Клим on 21.07.2022.
//

import UIKit

//MultipleChoiceDiary

protocol MultipleChoiceDiaryPresenterProtocol{
    init(view: MultipleChoiceDiaryViewProtocol, vcIndex: Int)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func getNumberOfItems() -> Int
    func getSelectedAnswersCount() -> Int
    func prepareCell(cell: AnswerViewCell, index: IndexPath)
    func manageAnswer(index: IndexPath)
    func manageCustomAnswer(answer: String, index: IndexPath)
    func prepareView()
}

class MultipleChoiceDiaryPresenter: MultipleChoiceDiaryPresenterProtocol{
    weak var view: MultipleChoiceDiaryViewProtocol?
    var selectedCells = [IndexPath]()
    var selectedAnswers = [String]()
    var currIndex: Int!
    var titleQuestions = ["Привет! Как проходит твой день?", "Что ты чувствуешь в данный момент?", "Что тебя сегодня заряжает/радует?"]
    var answerData = [["Ужасно", "Плохо", "Обычно", "Хорошо", "Отлично"], ["грусть", "счастье", "гордость", "благодарность", "спокойствие", "возбужденность", "внимательность", "усталость", "стресс", "сонливость", "восхищение"], []]
    
    required init(view: MultipleChoiceDiaryViewProtocol, vcIndex: Int) {
        self.view = view
        self.currIndex = vcIndex
    }
    
    func prepareView() {
        self.view?.loadQuestion(question: titleQuestions[currIndex])
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "moodSecondSegue":
            guard let vc = segue.destination as? SecondQuestionsViewController
            else {fatalError("invalid data passed")}
            vc.presenter = SecondQuestionsPresenter(view: vc, currMood: sender as! String)
            
        default:
            break
        }
    }
    
    func getNumberOfItems() -> Int {
        return answerData[currIndex].count + 1
    }
    
    func getSelectedAnswersCount() -> Int {
        return selectedAnswers.count
    }
    
    func manageCustomAnswer(answer: String, index: IndexPath){
        answerData[currIndex].append(answer)
        selectedAnswers.append(answer)
        selectedCells.append(index)
        
        view?.updateUI()
    }
    
    func manageAnswer(index: IndexPath) {
        let check = selectedAnswers.firstIndex(of: answerData[currIndex][index.row])
        if check == nil{
            selectedAnswers.append(answerData[currIndex][index.row])
            selectedCells.append(index)
        }
        else{
            selectedAnswers.remove(at: check!)
            let indexCell = selectedCells.firstIndex(of: index)
            selectedCells.remove(at: indexCell!)
        }
        view?.updateUI()
    }
    
    func prepareCell(cell: AnswerViewCell, index: IndexPath) {
        cell.textLabel.textColor = grayTextColor
        cell.layer.cornerRadius = 10
        let check = selectedCells.firstIndex(of: index)
        if check == nil{
            if index.row > answerData[currIndex].count - 1{
                cell.textLabel.text = "+"
                cell.backgroundColor = .white
                cell.layer.borderColor = lightYellowColor.cgColor
                cell.layer.borderWidth = 1
            }
            else{
                cell.backgroundColor = UIColor(red: 255, green: 244, blue: 204)
                cell.textLabel.text = answerData[currIndex][index.row]
            }
        }
        else{
            cell.backgroundColor = UIColor(red: 255, green: 239, blue: 184)
            cell.textLabel.text = answerData[currIndex][index.row]
        }
    }
}
