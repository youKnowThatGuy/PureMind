//
//  ReflexiveViewController.swift
//  PureMind
//
//  Created by Клим on 06.02.2022.
//

import UIKit

class ReflexiveViewController: UIViewController {

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
        titleLabel.textColor = UIColor(red: 211, green: 228, blue: 160)
        titleLabel.text = titleText
        discriptionLabel.textColor = grayTextColor
        discriptionLabel.text = descText
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        saveButtonShell.layer.cornerRadius = 15
        questionTextView.textColor = grayTextColor
        questionTextView.backgroundColor = .white
        questionTextView.layer.borderWidth = 2
        questionTextView.layer.borderColor = UIColor(red: 211, green: 228, blue: 160).cgColor
        questionTextView.layer.cornerRadius = 10
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
