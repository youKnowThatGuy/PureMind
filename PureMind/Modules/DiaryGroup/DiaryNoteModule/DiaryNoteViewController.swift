//
//  DiaryNoteViewController.swift
//  PureMind
//
//  Created by Клим on 11.07.2022.
//

import UIKit

class DiaryNoteViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var titlelABEL: UILabel!
    @IBOutlet weak var saveButtonShell: UIButton!
    var theme: String!
    var titleText = "Дневник"
    var descText = "Запиши свои мысли:"
    var buttonText = "Cохранить"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparView()
    }
    
    func preparView(){
        titlelABEL.text = titleText
        descLabel.text = descText
        self.view.backgroundColor = UIColor(red: 249, green: 225, blue: 183)
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        titlelABEL.textColor = .white
        noteTextView.backgroundColor = UIColor(red: 254, green: 250, blue: 234)
        //noteTextView.layer.borderWidth = 1
        noteTextView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        noteTextView.layer.cornerRadius = 10
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        saveButtonShell.layer.cornerRadius = 15
        saveButtonShell.setTitle(buttonText, for: .normal)
    }

    func alert(title: String,text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        switch titleText{
        case "Дневник":
        if noteTextView.text == ""{
            alert(title: "Вы не заполнили все доступные поля", text: "")
        }
        else{
            let info = DiaryNote(theme: self.theme, text: noteTextView.text , date: Int(Date().timeIntervalSince1970))
            CachingService.shared.cacheDiaryData(info, currDate: Date())
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 6], animated: true)
        }
        case "Перед сном 1.0":
            switch descText{
            case "Итак. Первая вещь, за которую ты чувствуешь благодарность сегодня:":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryNoteVC") as? DiaryNoteViewController)!
                vc.titleText = titleText
                vc.buttonText = "Далее"
                vc.descText = "Еще одна:"
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "Еще одна:":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryNoteVC") as? DiaryNoteViewController)!
                vc.titleText = titleText
                vc.buttonText = "Далее"
                vc.descText = "И третья вещь, за которую ты можешь поблагодарить себя:"
                self.navigationController?.pushViewController(vc, animated: true)
            
            case "И третья вещь, за которую ты можешь поблагодарить себя:":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryTextVC") as? DiaryTextViewController)!
                vc.titleText = titleText
                vc.buttonText = "Готово"
                vc.mainText = "Ты молодец! При ежедневной практике эта простая привычка благодарности может оказать мощное влияние на общее восприятие жизни, так что до встречи завтра!"
                self.navigationController?.pushViewController(vc, animated: true)
                
            default:
                break
            }
        case "Вечернее планирование":
            switch descText{
            case "Итак, сформулируй свою установку на завтра, записав как минимум одну вещь, которую хочешь сделать.":
                let vc = (self.storyboard?.instantiateViewController(withIdentifier: "DiaryTextVC") as? DiaryTextViewController)!
                vc.titleText = titleText
                vc.buttonText = "Далее"
                vc.hideTimePicker = false
                vc.mainText = "Прекрасно! А теперь запиши конкрет-ное время, когда ты это сделаешь. Здесь тебе нужно быть максимально точным в отношении сроков."
                self.navigationController?.pushViewController(vc, animated: true)
                
            default:
                break
            }

        default:
            break
        }
    }
}
