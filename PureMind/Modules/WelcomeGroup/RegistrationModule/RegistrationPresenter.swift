//
//  RegistrationPresenter.swift
//  PureMind
//
//  Created by Клим on 09.07.2021.
//

import UIKit


protocol RegistrationPresenterProtocol{
    init(view: RegistrationViewProtocol)
    func infoValidation(nickname: String, email: String, password: String) -> String
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class RegistrationPresenter: RegistrationPresenterProtocol{
    
    weak var view: RegistrationViewProtocol?
    
    required init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func infoValidation(nickname: String, email: String, password: String) -> String{
        if email == "" || nickname == "" || password == ""{
            return "Вы не заполнили все поля"
        }
        let clearEmail = stringClear(str: email)
        if clearEmail.latinCharactersOnly == false {
            return "Адрес почты должен быть на латинице»"
        }
        if email.contains("@") == false || email.contains(".") == false {
            return "Некорректный формат почты"
        }
        if password.count < 8 {
            return  "Минимальная длина пароля 8 символов"
        }
        
        if password.russianOnly.count != 0{
            return "Пароль должен быть на латинице»"
        }
        
        let decimalChars = CharacterSet.decimalDigits
        let letters = CharacterSet.letters
        let decimalRange = password.rangeOfCharacter(from: decimalChars)
        let letterRange = password.rangeOfCharacter(from: letters)
        
        if decimalRange == nil || letterRange == nil{
            return "Пароль должен содержать хотя бы одну цифру или букву"
        }
        return "pass"
    }
    
    
    func stringClear(str: String) -> String{
        var newStr = ""
        for char in str{
            if char != "@" && char != "."{
                newStr.append(char)
            }
        }
        return newStr
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "loginSegue":
            guard let vc = segue.destination as? LoginViewController
            else {fatalError("invalid data passed")}
            vc.presenter = LoginPresenter(view: vc)
            
        case "policiesShortSegue":
            guard let vc = segue.destination as? PoliciesShortViewController
            else {fatalError("invalid data passed")}
            vc.presenter = PoliciesShortPresenter(view: vc)
        
        case "themesSegue":
            guard let vc = segue.destination as? ThemesViewController
            else {fatalError("invalid data passed")}
            vc.presenter = ThemesPresenter(view: vc)
            
        default:
            break
        }
    }
    
}
