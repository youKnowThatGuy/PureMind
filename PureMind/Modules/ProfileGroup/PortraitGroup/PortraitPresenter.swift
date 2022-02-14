//
//  PortraitPresenter.swift
//  PureMind
//
//  Created by Клим on 02.02.2022.
//

import UIKit

protocol PortraitPresenterProtocol{
    init(view: PortraitViewProtocol)
    func prepareCell(cell: SingleTestViewCell, index: Int)
    func getTitleText(index: Int) -> String
    func countData() -> Int
}

class PortraitPresenter: PortraitPresenterProtocol{
    weak var view: PortraitViewProtocol?
    var tests = ["Эмоциональное выгорание", "Тревожность", "Идентичность", "Негативные установки", "Шкала базисных убеждений", "Профиль отношений", "Переживание перемен", "Самооценка"]
    var links = ["https://psytests.org/boyko/burnout-run.html", "https://psytests.org/psystate/spielberger.html", "https://psytests.org/projective/mili.html", "https://psytests.org/personal/ellis.html", "https://psytests.org/emotional/yanoff-run.html", "https://psytests.org/interpersonal/rpt.html", "https://psytests.org/coping/sacs.html", "https://psytests.org/emotional/ruvs.html"]
    
    required init(view: PortraitViewProtocol) {
        self.view = view
    }

    func prepareCell(cell: SingleTestViewCell, index: Int) {
        cell.urlString = links[index]
       
    }
    
    func getTitleText(index: Int) -> String {
        return tests[index]
    }
    
    func countData() -> Int {
        tests.count
    }

}

