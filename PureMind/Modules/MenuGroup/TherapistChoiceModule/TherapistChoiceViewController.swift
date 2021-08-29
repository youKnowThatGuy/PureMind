//
//  TherapistChoiceViewController.swift
//  PureMind
//
//  Created by Клим on 31.07.2021.
//

import UIKit

protocol TherapistChoiceViewProtocol: UIViewController{
    func updateUI()
}

class TherapistChoiceViewController: UIViewController {
    
    var presenter: TherapistChoicePresenterProtocol!
    @IBOutlet weak var soloChoiceView: UIView!
    @IBOutlet weak var therapistChoiceView: UIView!
    @IBOutlet weak var continueButtonShell: UIButton!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardTitleLabel1: UILabel!
    @IBOutlet weak var cardTitleLabel2: UILabel!
    @IBOutlet weak var cardDescLabel1: UILabel!
    @IBOutlet weak var cardDescLabel2: UILabel!
    
    
    
    var viewPressed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soloChoiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstViewPressed)))
        therapistChoiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondViewPressed)))
        prepareViews()
    }
    
    func prepareViews(){
        prepareLabels()
        soloChoiceView.backgroundColor = toxicYellow
        therapistChoiceView.backgroundColor = toxicYellow
        normalButtonState()
    }
    
    func prepareLabels(){
        let labels = [titleLable, descriptionLabel, cardTitleLabel1, cardTitleLabel2, cardDescLabel1, cardDescLabel2]
        for label in labels{
            label?.textColor = grayTextColor
        }
        
    }
    
    func selectedButtonState(){
        continueButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        continueButtonShell.setTitleColor(.white, for: .normal)
        continueButtonShell.setTitle("Подтвердить", for: .normal)
    }
    
    func normalButtonState(){
        continueButtonShell.layer.backgroundColor = .none
        continueButtonShell.setTitle("Пропустить", for: .normal)
        continueButtonShell.setTitleColor(grayButtonColor, for: .normal)
        continueButtonShell.layer.cornerRadius = 15
        continueButtonShell.layer.borderWidth = 2
        continueButtonShell.layer.borderColor = lightYellowColor.cgColor
    }
    
    @objc func firstViewPressed(){
        switch viewPressed {
        case 0:
            viewPressed = 1
            soloChoiceView.backgroundColor = toxicYellowSelected
            selectedButtonState()
        case 1:
            viewPressed = 0
            soloChoiceView.backgroundColor = toxicYellow
            normalButtonState()
        case 2:
            validationAlert(message: "")
        default:
            break
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        switch viewPressed {
        case 0:
            performSegue(withIdentifier: "registrationToMenuSeuge", sender: nil)
        case 1:
            performSegue(withIdentifier: "registrationToMenuSeuge", sender: nil)
        case 2:
            performSegue(withIdentifier: "therapistSubSegue", sender: nil)
        default:
            break
        }
    }
    
    @objc func secondViewPressed(){
        switch viewPressed {
        case 0:
            viewPressed = 2
            therapistChoiceView.backgroundColor = toxicYellowSelected
            selectedButtonState()
        case 1:
            validationAlert(message: "")
        case 2:
            viewPressed = 0
            therapistChoiceView.backgroundColor = toxicYellow
            normalButtonState()
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: nil)
    }
  
    func validationAlert(message: String){
        let alert = UIAlertController(title: "Выберите один вариант", message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }

}

extension TherapistChoiceViewController: TherapistChoiceViewProtocol{
    func updateUI() {
        print("Good!")
    }
    
    
}
