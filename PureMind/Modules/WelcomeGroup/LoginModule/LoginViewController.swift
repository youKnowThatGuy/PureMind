//
//  LoginViewController.swift
//  PureMind
//
//  Created by Клим on 10.07.2021.
//

import UIKit

protocol LoginViewProtocol: UIViewController{
    func updateUI()
    func loginAlert(text: String)
    func loginSuccess()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    
    @IBOutlet weak var assistButtonOutlet: UIButton!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var loginGoogleButtonOutlet: UIButton!
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    var passwordHidden = true
    var presenter: LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        prepareViews()
        prepareButtons()
        prepareTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.isHidden = true
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    func transformTextField(myTextField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 25 - 1, width: 300, height: 1.0)
        bottomLine.backgroundColor = blueBackgorundColor.cgColor
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    }
    
    func prepareButtons(){
        backButtonOutlet.tintColor = lightYellowColor
        assistButtonOutlet.setTitleColor(policiesButtonColor, for: .normal)
        //loginButtonOutlet.setTitleColor(lightYellowColor, for: .normal)
        
        loginButtonOutlet.backgroundColor = lightYellowColor
        loginButtonOutlet.layer.cornerRadius = 15
        
        loginGoogleButtonOutlet.layer.cornerRadius = 15
        loginGoogleButtonOutlet.backgroundColor = .clear
        loginGoogleButtonOutlet.layer.borderWidth = 2
        loginGoogleButtonOutlet.setTitleColor(grayButtonColor, for: .normal)
        loginGoogleButtonOutlet.layer.borderColor = lightYellowColor.cgColor
        
    }
    
    func prepareViews(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        titleLabel.textColor = grayTextColor
        emailLabel.textColor = grayTextColor
        passwordLabel.textColor = grayTextColor
        forgotPasswordLabel.textColor = textFieldColor
    }
    
    func prepareTextFields(){
        emailTextField.delegate = self
        emailTextField.textColor = textFieldColor
        transformTextField(myTextField: emailTextField)
        passwordTextField.delegate = self
        passwordTextField.textColor = textFieldColor
        transformTextField(myTextField: passwordTextField)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let message = presenter.infoValidation(email: emailTextField.text!, password: passwordTextField.text!)
        if message == "pass"{
            presenter.performLogin(email: emailTextField.text!, password: passwordTextField.text!)
            
        }
        else{
            //validationAlert(message: message)
        }
        presenter.performLogin(email: emailTextField.text!, password: passwordTextField.text!)

    }
    
    @IBAction func passwordVisiblePressed(_ sender: UIButton) {
        if passwordHidden == true{
            passwordTextField.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_closed"), for: .normal)
        }
        else{
            passwordTextField.isSecureTextEntry = true
            sender.setImage(UIImage(named: "custom_eye"), for: .normal)
        }
        passwordHidden = !passwordHidden
    }
    
    
    
    @IBAction func googleButtonPressed(_ sender: Any) {
    }
    
    @IBAction func assistButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "restorePasswordSegue", sender: nil)
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

extension LoginViewController: LoginViewProtocol{
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
