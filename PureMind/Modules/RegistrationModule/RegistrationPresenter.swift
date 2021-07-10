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
    
}

extension String {
    var latinCharactersOnly: Bool {
        return self.range(of: "\\P{Latin}", options: .regularExpression) == nil
    }
    
    var stripped: String {
            let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
            return self.filter {okayChars.contains($0) }
        }
    
    var russianOnly: String{
        let okayChars = Set("йцукенгшщзхъфывапролджэёячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮ")
        return self.filter {okayChars.contains($0) }
    }
}
