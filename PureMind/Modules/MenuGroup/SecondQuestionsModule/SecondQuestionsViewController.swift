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
    @IBOutlet weak var topView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.addDoneButton(title: "Готово", target: self, selector: #selector(tapDone(sender:)))
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
        topView.layer.cornerRadius = 20
        moodTitleLabel.textColor = newButtonLabelColor
        questionTitleLabel.textColor = newButtonLabelColor
        answerTextField.backgroundColor = .white
        answerTextField.layer.borderWidth = 1
        answerTextField.layer.borderColor = newButtonLabelColor.cgColor
        answerTextField.layer.cornerRadius = 20
        continueButtonShell.layer.cornerRadius = 20
        continueButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
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
            self.topView.backgroundColor = perfectMood
            continueButtonShell.backgroundColor = perfectMood
        case "Хорошо":
            self.topView.backgroundColor = goodMood
            continueButtonShell.backgroundColor = goodMood
        case "Нормально":
            self.topView.backgroundColor = normalMood
            continueButtonShell.backgroundColor = normalMood
        case "Плохо":
            self.topView.backgroundColor = badMood
            continueButtonShell.backgroundColor = badMood
        case "Ужасно":
            self.topView.backgroundColor = awfulMood
            continueButtonShell.backgroundColor = awfulMood
        default:
            self.view.backgroundColor = .white
        }
    }
    
    
}
