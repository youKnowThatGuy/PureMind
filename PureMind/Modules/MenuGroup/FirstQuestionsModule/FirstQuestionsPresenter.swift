//
//  FirstQuestionsPresenter.swift
//  PureMind
//
//  Created by Клим on 16.08.2021.
//

import UIKit

protocol FirstQuestionsPresenterProtocol{
    init(view: FirstQuestionsViewProtocol, currMood: String)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func getNumberOfSections() -> Int
    func getNumberOfItems(section: Int) -> Int
    func getSelectedAnswersCount() -> Int
    func prepareCell(cell: AnswerViewCell, index: IndexPath)
    func manageAnswer(index: IndexPath)
    func manageCustomAnswer(answer: String, index: IndexPath)
    func prepareView()
    var currMood: String? {get}
}

class FirstQuestionsPresenter: FirstQuestionsPresenterProtocol{
    weak var view: FirstQuestionsViewProtocol?
    var currMood: String?
    var selectedCells = [IndexPath]()
    var selectedAnswers = [String]()
    var phonyData = [["good", "awesome", "mediocre", "bad", "gruesome", "sad", "complexed"]]
    
    required init(view: FirstQuestionsViewProtocol, currMood: String) {
        self.view = view
        self.currMood = currMood
    }
    
    func prepareView(){
        view?.loadQuestion(mood: currMood!, questionTitle: "", questionDesc: "")
        view?.loadMood(mood: currMood!)
        switch currMood {
        case "Отлично":
            view?.setBackgroundColor(color: perfectMood)
        case "Хорошо":
            view?.setBackgroundColor(color: goodMood)
        case "Нормально":
            view?.setBackgroundColor(color: normalMood)
        case "Плохо":
            view?.setBackgroundColor(color: badMood)
        case "Ужасно":
            view?.setBackgroundColor(color: awfulMood)
        default:
            view?.setBackgroundColor(color: .white)
        }
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
    
    func getNumberOfItems(section: Int) -> Int {
        return phonyData[section].count + 1
    }
    
    func getNumberOfSections() -> Int {
        return phonyData.count
    }
    
    func getSelectedAnswersCount() -> Int {
        return selectedAnswers.count
    }
    
    func manageCustomAnswer(answer: String, index: IndexPath){
        phonyData[index.section].append(answer)
        selectedAnswers.append(answer)
        selectedCells.append(index)
        
        view?.updateUI()
    }
    
    func manageAnswer(index: IndexPath) {
        let check = selectedAnswers.firstIndex(of: phonyData[index.section][index.row])
        if check == nil{
            selectedAnswers.append(phonyData[index.section][index.row])
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
        cell.layer.borderColor = grayButtonColor.cgColor
        cell.layer.borderWidth = 1
        if index.row > phonyData[index.section].count - 1{
            cell.textLabel.text = "+"
        }
        else{
            let check = selectedCells.firstIndex(of: index)
            if check == nil{
                cell.backgroundColor = .white
            }
            else{
                cell.backgroundColor = lightYellowColor
            }
            cell.textLabel.text = phonyData[index.section][index.row]
        }
    }
}
