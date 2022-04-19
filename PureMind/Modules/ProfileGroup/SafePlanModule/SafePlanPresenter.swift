//
//  SafePlanPresenter.swift
//  PureMind
//
//  Created by Клим on 25.02.2022.
//

import UIKit

protocol SafePlanPresenterProtocol{
    init(view: SafePlanViewProtocol)
    func preparePlanCell(cell: SafePlanTableViewCell, index: Int)
    func prepareTitleCell(cell: ExpTitlePlanCell, index: Int)
    func plansCount() -> Int
    func insertPlan(str: String, index: Int)
    func loadData()
    func cacheData()
}

class SafePlanPresenter: SafePlanPresenterProtocol{
    weak var view: SafePlanViewProtocol?
    
    var texts = ["Здесь может быть ваш текст", "Здесь может быть ваш текст", "Здесь может быть ваш текст"]
    
    required init(view: SafePlanViewProtocol) {
        self.view = view
    }
    
    func plansCount() -> Int {
        3
    }
    
    func insertPlan(str: String, index: Int) {
        texts[index] = str
        self.view?.updateUI()
    }
    
    func preparePlanCell(cell: SafePlanTableViewCell, index: Int) {
        cell.parentPresenter = self
        cell.cellIndex = index
    }
    
    func prepareTitleCell(cell: ExpTitlePlanCell, index: Int) {
        cell.titleLabel.text = "Заметка №\(index + 1)"
        cell.planLabel.text = texts[index]
    }
    
    func loadData() {
        CachingService.shared.getPlansInfo {[weak self] (result) in
            if result != nil{
                self?.texts = result!.texts
                self?.view?.updateUI()
            }
        }
    }
    
    func cacheData() {
        CachingService.shared.cachePlansInfo(SafePlanInfo(texts: texts))
    }

}
