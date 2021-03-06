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
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var policyLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
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
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        prepareButtons()
        prepareTextFields()
        prepareLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.isHidden = true
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    func prepareButtons(){
        backButtonOutlet.tintColor = lightYellowColor
        policiesButtonOutlet.setTitleColor(policiesButtonColor, for: .normal)
        loginButtonOutlet.setTitleColor(lightYellowColor, for: .normal)
        
        registrationButtonOutlet.backgroundColor = lightYellowColor
        registrationButtonOutlet.layer.cornerRadius = 15
        
        googleButtonOutlet.layer.cornerRadius = 15
        googleButtonOutlet.backgroundColor = .clear
        googleButtonOutlet.layer.borderWidth = 2
        googleButtonOutlet.setTitleColor(grayButtonColor, for: .normal)
        googleButtonOutlet.layer.borderColor = lightYellowColor.cgColor
    }
    
    func transformTextField(myTextField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 25 - 1, width: 300, height: 1.0)
        bottomLine.backgroundColor = blueBackgorundColor.cgColor
        myTextField.borderStyle = UITextField.BorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    }
    
    func prepareLabels(){
        titleLabel.textColor = grayTextColor
        nameLabel.textColor = grayTextColor
        emailLabel.textColor = grayTextColor
        passwordLabel.textColor = grayTextColor
        policyLabel.textColor = grayTextColor
        loginLabel.textColor = textFieldColor
    }
    
    func prepareTextFields(){
        nicknameField.delegate = self
        nicknameField.textColor = textFieldColor
        transformTextField(myTextField: nicknameField)
        emailField.delegate = self
        emailField.textColor = textFieldColor
        transformTextField(myTextField: emailField)
        passwordField.delegate = self
        passwordField.textColor = textFieldColor
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
