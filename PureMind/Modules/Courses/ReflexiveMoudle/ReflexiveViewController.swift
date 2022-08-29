//
//  ReflexiveViewController.swift
//  PureMind
//
//  Created by Клим on 06.02.2022.
//

import UIKit

class ReflexiveViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UITextView!
    @IBOutlet weak var saveButtonShell: UIButton!
    @IBOutlet weak var questionTextView: UITextView!
    var titleText = ""
    var descText = ""
    var vcIndex: Int!
    var lessonIndex: Int!
    var courseId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        prepareViews()
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    func prepareViews(){
        topView.backgroundColor = UIColor(patternImage: UIImage(named: "background15")!)
        topView.layer.cornerRadius = 20
        titleLabel.textColor = newButtonLabelColor
        titleLabel.text = titleText
        discriptionLabel.textColor = newButtonLabelColor
        discriptionLabel.text = descText
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = newButtonLabelColor.cgColor
        saveButtonShell.layer.cornerRadius = 20
        questionTextView.textColor = newButtonLabelColor
        questionTextView.backgroundColor = .white
        questionTextView.layer.borderWidth = 1
        questionTextView.layer.borderColor = newButtonLabelColor.cgColor
        questionTextView.layer.cornerRadius = 20
    }
    
    func alert(message: String){
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if questionTextView.hasText == true{
            alert(message: "Ваш ответ записан!")
            if courseId != ""{
                CachingService.shared.cacheReflexAnswer(id: courseId, relfexId: vcIndex, lessonId: lessonIndex)
            }
            
        }
        else{
           alert(message: "Вы не заполнили вопрос.")
        }
    }
}
