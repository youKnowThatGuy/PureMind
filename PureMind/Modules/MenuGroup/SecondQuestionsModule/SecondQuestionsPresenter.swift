//
//  SecondQuestionsPresenter.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//
import UIKit

protocol SecondQuestionsPresenterProtocol{
    init(view: SecondQuestionsViewProtocol, currMood: String)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    var currMood: String? {get}
}

class SecondQuestionsPresenter: SecondQuestionsPresenterProtocol{
    weak var view: SecondQuestionsViewProtocol?
    var currMood: String?
    
    required init(view: SecondQuestionsViewProtocol, currMood: String) {
        self.view = view
        self.currMood = currMood
    }
    
    func prepareView(){
        view?.loadQuestion(questionTitle: "Интересный вопрос")
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "moodMenuSegue":
            guard let vc = segue.destination as? MoodViewController
            else {fatalError("invalid data passed")}
            vc.presenter = MoodPresenter(view: vc, currMood: sender as! String)
            
        default:
            break
        }
    }
    
}
