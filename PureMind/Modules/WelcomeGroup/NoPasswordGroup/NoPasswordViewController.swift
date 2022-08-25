//
//  NoPasswordViewController.swift
//  PureMind
//
//  Created by Клим on 21.01.2022.
//

import UIKit

protocol NoPasswordViewProtocol: UIViewController{
    func updateUI()
    func loginAlert(text: String)
    func loginSuccess()
}

class NoPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!

    
    var passwordHidden = true
    
    var presenter: NoPasswordPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLabels()
        prepareButtons()
        prepareTextFields()
    }
    
    func transformTextField(myTextField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 25 - 1, width: 265, height: 1.0)
        bottomLine.backgroundColor = lightTextColor.cgColor
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    }
    
    func prepareButtons(){
        loginButtonOutlet.backgroundColor = newButtonLabelColor
        loginButtonOutlet.layer.cornerRadius = 15
    }
    
    func prepareLabels(){
        titleLabel.textColor = grayTextColor
        emailLabel.textColor = grayTextColor
    }
    
    func prepareTextFields(){
        emailTextField.delegate = self
        emailTextField.textColor = lightTextColor
        transformTextField(myTextField: emailTextField)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let message = presenter.infoValidation(email: emailTextField.text!)
        if message == "pass"{
            //presenter.performRestore(email: emailTextField.text!)
            
        }
        else{
            //validationAlert(message: message)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func validationAlert(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension NoPasswordViewController: NoPasswordViewProtocol{
    func updateUI() {
        print("Good!")
    }
    
    func loginAlert(text: String){
        validationAlert(message: text)
    }
    
    func loginSuccess(){
        performSegue(withIdentifier: "loginToMenuSegue", sender: nil)
    }
}

extension NoPasswordViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        return updatedText.count <= 35
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

