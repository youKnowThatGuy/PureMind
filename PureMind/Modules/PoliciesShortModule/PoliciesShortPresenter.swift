//
//  PoliciesShortPresenter.swift
//  PureMind
//
//  Created by Клим on 11.07.2021.
//

import UIKit

protocol PoliciesShortPresenterProtocol{
    init(view: PoliciesShortViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func prepareCell(cell: ShortPolicyViewCell)
    func getTitleText(index: Int) -> String
    func countData() -> Int
}

class PoliciesShortPresenter: PoliciesShortPresenterProtocol{
    weak var view: PoliciesShortViewProtocol?
    
    required init(view: PoliciesShortViewProtocol) {
        self.view = view
    }
    
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "policiesFullSegue":
            guard let vc = segue.destination as? PoliciesFullViewController
            else {fatalError("invalid data passed")}
            vc.presenter = PoliciesFullPresenter(view: vc)
            
        default:
            break
        }
    }
    
    func prepareCell(cell: ShortPolicyViewCell) {
        cell.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam at orci vitae augue sodales aliquet consequat at est. Etiam ante ligula, viverra ut lacus nec."
    }
    
    func getTitleText(index: Int) -> String {
        return "Правило №\(index + 1)"
    }
    
    func countData() -> Int {
        return 4
    }
    
    
}

