//
//  SecondQuestionsViewController.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//

import UIKit

protocol SecondQuestionsViewProtocol: UIViewController{
    func updateUI()
    
    func loadQuestion(questionTitle: String)
    
}

class SecondQuestionsViewController: UIViewController {
    var presenter: SecondQuestionsPresenterProtocol!
    var vcIndex = 3
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var continueButtonShell: UIButton!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var backButtonShell: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIndex()
        
    }
    
    func checkIndex(){
        if vcIndex == 4{
            continueButtonShell.setTitle("Завершить", for: .normal)
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if vcIndex < 4 {
            let vc = ModuleBuilder().createMoodModuleTwo(mood: presenter.currMood!, vcIndex: vcIndex + 1)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else{
            performSegue(withIdentifier: "moodMenuSegue", sender: presenter.currMood)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
}

extension SecondQuestionsViewController: SecondQuestionsViewProtocol{
    func loadQuestion(questionTitle: String) {
        questionTitleLabel.text = questionTitle
    }
    
    func updateUI() {
        print("Good!")
    }
    
    
}
