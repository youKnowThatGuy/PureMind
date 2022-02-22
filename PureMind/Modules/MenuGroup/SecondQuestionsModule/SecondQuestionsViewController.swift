//
//  SecondQuestionsViewController.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//

import UIKit

protocol SecondQuestionsViewProtocol: UIViewController, UITextFieldDelegate{
    func updateUI(mood: String)
    
    func loadQuestion(questionTitle: String)
    
}

class SecondQuestionsViewController: UIViewController {
    var presenter: SecondQuestionsPresenterProtocol!
    var vcIndex = 3
    
    @IBOutlet weak var moodTitleLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var continueButtonShell: UIButton!
    @IBOutlet weak var answerTextField: UITextView!
    @IBOutlet weak var backButtonShell: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.view.backgroundColor = UIColor(red: 254, green: 235, blue: 138)
        checkIndex()
        prepareViews()
        updateUI(mood: presenter.currMood!)
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
        
    }
    
    func prepareViews(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        moodTitleLabel.textColor = .white
        questionTitleLabel.textColor = .white
        backButtonShell.tintColor = .white
        answerTextField.backgroundColor = .white
        answerTextField.layer.borderWidth = 0
        answerTextField.layer.borderColor = UIColor(red: 255, green: 255, blue: 255).cgColor
        answerTextField.layer.cornerRadius = 20
        continueButtonShell.backgroundColor = lightYellowColor
        continueButtonShell.layer.cornerRadius = 15
    }
    
    func checkIndex(){
        switch vcIndex {
        case 3:
            questionTitleLabel.text = "Какие позитивные моменты произошли за сегодня?"
        case 4:
            questionTitleLabel.text = "Над чем сегодня удалось поработать? Возможно, были какие-то инсайты? Поделись ими здесь"
            continueButtonShell.setTitle("Завершить", for: .normal)
        default:
            print("error")
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        continueButtonShell.isHidden = false
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
    
    func updateUI(mood: String) {
        moodTitleLabel.text = mood
        switch mood {
        case "Отлично":
            self.view.backgroundColor = perfectMood
        case "Хорошо":
            self.view.backgroundColor = goodMood
        case "Нормально":
            self.view.backgroundColor = normalMood
        case "Плохо":
            self.view.backgroundColor = badMood
        case "Ужасно":
            self.view.backgroundColor = awfulMood
        default:
            self.view.backgroundColor = .white
        }
    }
    
    
}
