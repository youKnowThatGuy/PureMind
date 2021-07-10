//
//  RegistrationViewController.swift
//  PureMind
//
//  Created by Клим on 09.07.2021.
//

import UIKit

protocol RegistrationViewProtocol: UIViewController{
    func updateUI()
}

class RegistrationViewController: UIViewController {
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkBox: CheckBox!
    var presenter: RegistrationPresenterProtocol!
    var passwordHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func passwordVisiblePressed(_ sender: Any) {
        if passwordHidden == true{
            passwordField.isSecureTextEntry = false
        }
        else{
            passwordField.isSecureTextEntry = true
        }
        passwordHidden = !passwordHidden
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let message = presenter.infoValidation(nickname: nicknameField.text!, email: emailField.text!, password: passwordField.text!)
        if message == "pass"{
            if checkBox.isChecked == true{
                validationAlert(message: "Проверка завершена успешно!")
            }
            else{
              validationAlert(message: "Вы не согласились с условиями пользования")
            }
        }
        else{
            validationAlert(message: message)
        }
        
    }
    
    func validationAlert(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerThroughGoogle(_ sender: Any) {
    }
    
    @IBAction func policiesButtonPressed(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    
}

extension RegistrationViewController: RegistrationViewProtocol{
    func updateUI() {
        print("Good!")
    }
}

extension RegistrationViewController: UITextFieldDelegate{
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
}
