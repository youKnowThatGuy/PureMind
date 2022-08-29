//
//  DiaryThemeViewController.swift
//  PureMind
//
//  Created by Клим on 21.07.2022.
//

import UIKit

class DiaryThemeViewController: UIViewController {

    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeTextView: UITextView!
    @IBOutlet weak var saveButtonShell: UIButton!
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var secondTextLabel: UILabel!
    var titleText = "Дневник"
    var firstText = "Дай название своему дню:"
    var hideViews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparView()
    }
    
    func preparView(){
        topView.backgroundColor = UIColor(red: 248, green: 232, blue: 187)
        topView.layer.cornerRadius = 20
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        titleLabel.textColor = newButtonLabelColor
        noteTextView.backgroundColor = UIColor(red: 254, green: 250, blue: 234)
        noteTextView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        noteTextView.layer.cornerRadius = 20
        
        themeTextView.backgroundColor = UIColor(red: 254, green: 250, blue: 234)
        themeTextView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        themeTextView.layer.cornerRadius = 20
        
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = newButtonLabelColor.cgColor
        saveButtonShell.layer.cornerRadius = 20
        firstTextLabel.text = firstText
        titleLabel.text = titleText
        
        noteTextView.isHidden = hideViews
        secondTextLabel.isHidden = hideViews
    }
    
    func alert(title: String,text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showDiaryNoteSegue":
            guard let vc = segue.destination as? DiaryNoteViewController, let string = sender as? String
            else {fatalError("invalid data passed")}
            vc.theme = string
            
        default:
            break
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if themeTextView.text == "" && noteTextView.text == ""{
            alert(title: "Вы не заполнили все доступные поля", text: "")
        }
        else{
            switch titleText{
            case "Дневник":
                performSegue(withIdentifier: "showDiaryNoteSegue", sender: themeTextView.text)
                
            case "Перед сном 2.0":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryTextVC") as? DiaryTextViewController)!
                vc.titleText = titleText
                vc.buttonText = "Далее"
                vc.mainText = "Последний вопрос, который поможет приятно завершить этот день."
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
}
