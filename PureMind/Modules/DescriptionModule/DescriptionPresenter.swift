//
//  DescriptionPresenter.swift
//  PureMind
//
//  Created by Клим on 07.07.2021.
//

import UIKit


protocol DescriptionPresenterProtocol{
    init(view: DescriptionViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func prepareCell(cell: CardViewCell, index: Int)
    func cardCount() -> Int
}

class DescriptionPresenter: DescriptionPresenterProtocol{
    
    weak var view: DescriptionViewProtocol?
    var testInfo = ["some text goes here", "some text goes here", "some text goes here", "some text goes here", "some text goes here"]
    
    required init(view: DescriptionViewProtocol) {
        self.view = view
    }
    
    func cardCount() -> Int {
        testInfo.count
    }
    
    func prepareCell(cell: CardViewCell, index: Int) {
        cell.titleLabel.text = "Карточка № \(index)"
        cell.cardImage.image = UIImage(named: "noImage")
        cell.mainTextLabel.text = testInfo[index]
        
        cell.backgroundColor = .gray
        cell.layer.cornerRadius = 20
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "registrationSegue":
            guard let vc = segue.destination as? RegistrationViewController
            else {fatalError("invalid data passed")}
            vc.presenter = RegistrationPresenter(view: vc)
            
        default:
            break
        }
    }

}
