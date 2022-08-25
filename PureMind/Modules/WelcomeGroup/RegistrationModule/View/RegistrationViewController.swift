//
//  RegistrationViewController.swift
//  PureMind
//
//  Created by Клим on 09.07.2021.
//

import UIKit

protocol RegistrationViewProtocol: UIViewController{
    func updateUI()
    func registerAlert(text: String)
    func registerSuccess()
}

class RegistrationViewController: UIViewController {
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var checkBox: CheckBox!
    
    @IBOutlet weak var policiesButtonOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var registrationButtonOutlet: UIButton!
    @IBOutlet weak var googleButtonOutlet: UIButton!
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    @IBOutlet weak var registrationView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var policyLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [UIColor(red: 239, green: 243, blue: 255),
        UIColor(red: 255, green: 252, blue: 250)]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()

    var presenter: RegistrationPresenterProtocol!
    var passwordHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(tap)
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        prepareButtons()
        prepareTextFields()
        prepareLabels()
        _ = Timer.scheduledTimer(
          timeInterval: 0.5, target: self, selector: #selector(verifyCheckBox),
          userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //imageView.isHidden = true
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func verifyCheckBox(){
        if checkBox.isChecked == true && nicknameField.text != "" && passwordField.text != "" && emailField.text != "" {
            registrationButtonOutlet.backgroundColor = newButtonLabelColor
            registrationButtonOutlet.setTitleColor(.white, for: .normal)
        }
        else{
            registrationButtonOutlet.backgroundColor = .white
            registrationButtonOutlet.layer.cornerRadius = 15
            registrationButtonOutlet.layer.borderColor = UIColor(red: 255, green: 252, blue: 250).cgColor
            registrationButtonOutlet.setTitleColor(lightTextColor, for: .normal)
        }
    }
    
    func prepareButtons(){
        registrationView.layer.cornerRadius = 28
        registrationView.backgroundColor = .white
        registrationView.layer.borderWidth = 1
        registrationView.layer.borderColor = UIColor(red: 178, green: 186, blue: 230).cgColor
        
        backButtonOutlet.tintColor = lightYellowColor
        policiesButtonOutlet.setTitleColor(policiesButtonColor, for: .normal)
        loginButtonOutlet.setTitleColor(newButtonLabelColor, for: .normal)
        
        registrationButtonOutlet.backgroundColor = .white
        registrationButtonOutlet.layer.cornerRadius = 15
        registrationButtonOutlet.layer.borderWidth = 1
        registrationButtonOutlet.layer.borderColor = UIColor(red: 255, green: 252, blue: 250).cgColor
        registrationButtonOutlet.setTitleColor(lightTextColor, for: .normal)
        
        googleButtonOutlet.layer.cornerRadius = 15
        googleButtonOutlet.backgroundColor = .clear
        googleButtonOutlet.layer.borderWidth = 2
        googleButtonOutlet.setTitleColor(grayButtonColor, for: .normal)
        googleButtonOutlet.layer.borderColor = lightYellowColor.cgColor
    }
    
    func transformTextField(myTextField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 25 - 1, width: 265, height: 1.0)
        bottomLine.backgroundColor = lightTextColor.cgColor
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    }
    
    func prepareLabels(){
        titleLabel.textColor = newButtonLabelColor
        nameLabel.textColor = newButtonLabelColor
        emailLabel.textColor = newButtonLabelColor
        passwordLabel.textColor = newButtonLabelColor
        policyLabel.textColor = newButtonLabelColor
        loginLabel.textColor = newButtonLabelColor
    }
    
    func prepareTextFields(){
        nicknameField.delegate = self
        nicknameField.textColor = lightTextColor
        transformTextField(myTextField: nicknameField)
        emailField.delegate = self
        emailField.textColor = lightTextColor
        transformTextField(myTextField: emailField)
        passwordField.delegate = self
        passwordField.textColor = lightTextColor
        transformTextField(myTextField: passwordField)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func passwordVisiblePressed(_ sender: UIButton) {
        if passwordHidden == true{
            passwordField.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_closed"), for: .normal)
        }
        else{
            passwordField.isSecureTextEntry = true
            sender.setImage(UIImage(named: "custom_eye"), for: .normal)
        }
        passwordHidden = !passwordHidden
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let message = presenter.infoValidation(nickname: nicknameField.text!, email: emailField.text!, password: passwordField.text!)
        if message == "pass"{
            if checkBox.isChecked == true{
                validationAlert(title: "Успешно!", message: "Добро пожаловать в PureMind!")
                presenter.performRegistration(nickname: nicknameField.text!, email: emailField.text!, password: passwordField.text!)
            }
            else{
                validationAlert(title: "Внимание!", message: "Вы не согласились с условиями пользования")
            }
        }
        else{
            validationAlert(title: "Ошибка", message: message)
        }
    }
    
    func validationAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerThroughGoogle(_ sender: Any) {
    }
    
    @IBAction func policiesButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "policiesShortSegue", sender: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
    
}

extension RegistrationViewController: RegistrationViewProtocol{
    func updateUI() {
        print("Good!")
    }
    
    func registerSuccess(){
        performSegue(withIdentifier: "skipSegue", sender: nil)
    }
    
    func registerAlert(text: String){
        validationAlert(title: "Ошибка", message: text)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
