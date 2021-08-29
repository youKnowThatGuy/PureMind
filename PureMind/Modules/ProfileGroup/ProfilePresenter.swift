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
    
    var imagesNames = ["person.crop.circle.fill", "book.fill", "phone.circle", "message.fill", "book", "questionmark.circle.fill", "arrowshape.turn.up.backward.circle.fill"]
    var optionsNames = ["Психологический портрет", "Мои курсы", "Ресурсы чрезвычайной помощи", "Наши соцсети", "Политика конфиденциальности", "Популярные вопросы", "Выйти"]
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "policiesShortSegueSecond":
            guard let vc = segue.destination as? PoliciesShortViewController
            else {fatalError("invalid data passed")}
            vc.presenter = PoliciesShortPresenter(view: vc)
            
        default:
            break
        }
    }
    
    func optionsCount() -> Int {
        return 5
    }
    
    func prepareCell(cell: ProfileViewCell, index: Int) {
        cell.optionImageView.image = UIImage(systemName: imagesNames[index])
        cell.optionTitleLabel.text = optionsNames[index]
    }
    
}
