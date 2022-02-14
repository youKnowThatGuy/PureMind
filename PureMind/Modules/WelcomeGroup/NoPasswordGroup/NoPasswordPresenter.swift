//
//  NoPasswordPresenter.swift
//  PureMind
//
//  Created by Клим on 21.01.2022.
//

import UIKit

protocol NoPasswordPresenterProtocol{
    init(view: NoPasswordViewProtocol)
    func infoValidation(email: String) -> String
    func performRestore(email: String)
}

class NoPasswordPresenter: NoPasswordPresenterProtocol{
    weak var view: NoPasswordViewProtocol?
    let networkService = NetworkService.shared
    let cacheService = CachingService.shared
    
    required init(view: NoPasswordViewProtocol) {
        self.view = view
    }
    
    func infoValidation(email: String) -> String {
        if email == "" {
            return "Вы не заполнили все поля"
        }
        let clearEmail = stringClear(str: email)
        if clearEmail.latinCharactersOnly == false {
            return "Адрес почты должен быть на латинице»"
        }
        if email.contains("@") == false || email.contains(".") == false {
            return "Некорректный формат почты"
        }
        return "pass"
    }
    
    func performRestore(email: String) {
        networkService.logIN(login: email, password: "") { (result) in
            switch result{
            case let .success(token):
                self.networkService.apiKey = token
                self.cacheService.cacheInfo(UserInfo(login: email, password: "", token: token))
                self.view?.loginSuccess()
                
            case .failure(_):
                self.view?.loginAlert(text: "Воccтановить пароль не удалось. Пожалуйста, проверьте логин и попробуйте снова")
            }
        }
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
