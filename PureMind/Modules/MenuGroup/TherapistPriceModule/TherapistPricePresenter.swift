//
//  TherapistPricePresenter.swift
//  PureMind
//
//  Created by Клим on 12.09.2021.
//

import UIKit

protocol TherapistPricePresenterProtocol{
    init(view: TherapistPriceViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func tarifsCount() -> Int
    func prepareCell(cell: TariffViewCell, index: Int)
}

class TherapistPricePresenter: TherapistPricePresenterProtocol{
    weak var view: TherapistPriceViewProtocol?
    
    required init(view: TherapistPriceViewProtocol) {
        self.view = view
    }
    
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "chatSegue":
            guard let vc = segue.destination as? TherapistChoiceViewController
            else {fatalError("invalid data passed")}
            vc.presenter = TherapistChoicePresenter(view: vc)
            
        default:
            break
        }
    }
    
    func tarifsCount() -> Int {
        return 2
    }
    
    func prepareCell(cell: TariffViewCell, index: Int) {
        cell.prepareCellLayout()
        if index == 0{
            cell.priceLabel.text = "2000 рублей с 25% скидкой"
            cell.sessionsLabel.text = "12 сессий"
            cell.textLabelOne.text = "almd;amsfamf;ams;mfa"
            cell.textLabelTwo.text = "kdkddkdkdkdkdk"
        }
        else{
            cell.priceLabel.text = "1000 рублей"
            cell.sessionsLabel.text = "8 сессий"
            cell.textLabelOne.text = "fdsfdsfd"
            cell.textLabelTwo.text = "fkkfkfkf"
            cell.recomendationLabel.backgroundColor = .white
        }
    }
    
}
