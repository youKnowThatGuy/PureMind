//
//  LoginViewController.swift
//  PureMind
//
//  Created by Клим on 10.07.2021.
//

import UIKit

protocol LoginViewProtocol: UIViewController{
    func updateUI()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter: LoginPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let message = presenter.infoValidation(email: emailTextField.text!, password: passwordTextField.text!)
        if message == "pass"{
            validationAlert(message: "Проверка завершена успешно!")
        }
        else{
            validationAlert(message: message)
        }
    }
    
    @IBAction func googleButtonPressed(_ sender: Any) {
    }
    
    @IBAction func assistButtonPressed(_ sender: Any) {
    }
    
    func validationAlert(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension LoginViewController: LoginViewProtocol{
    func updateUI() {
        print("Good!")
    }
}

extension LoginViewController: UITextFieldDelegate{
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
