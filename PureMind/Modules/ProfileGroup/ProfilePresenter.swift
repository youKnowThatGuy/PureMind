//
//  ProfilePresenter.swift
//  PureMind
//
//  Created by Клим on 17.08.2021.
//
import UIKit

protocol ProfilePresenterProtocol{
    init(view: ProfileViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func prepareCell(cell: ProfileViewCell, index: Int)
    func optionsCount() -> Int
}

class ProfilePresenter: ProfilePresenterProtocol{
    weak var view: ProfileViewProtocol?
    
    var imagesNames = ["tabBar5", "helpImage", "contactsImage", "policyImage", "aboutUsImage", "shareImage", "exitImage", "cancelButton2"]
    var optionsNames = ["Психологический портрет", "Ресурсы чрезвычайной помощи", "Контакты", "Политика конфиденциальности", "О нас", "Поделиться", "Выйти", "Удалить аккаунт"]
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "policiesShortSegueSecond":
            guard let vc = segue.destination as? PoliciesShortViewController
            else {fatalError("invalid data passed")}
            vc.presenter = PoliciesShortPresenter(view: vc)
        
        case "showPortraitSegue":
            guard let vc = segue.destination as? PortraitViewController
            else {fatalError("invalid data passed")}
            vc.presenter = PortraitPresenter(view: vc)
            
        default:
            break
        }
    }
    
    func optionsCount() -> Int {
        return optionsNames.count
    }
    
    func prepareCell(cell: ProfileViewCell, index: Int) {
        cell.optionImageView.image = UIImage(named: imagesNames[index])
        cell.optionTitleLabel.text = optionsNames[index]
        cell.optionTitleLabel.textColor = grayTextColor
        cell.layer.cornerRadius = 28
    }
    
}
