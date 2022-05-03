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
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class PortraitPresenter: PortraitPresenterProtocol{
    weak var view: PortraitViewProtocol?
    var tests = ["Эмоциональное выгорание", "Тревожность", "Идентичность", "Негативные установки", "Шкала базисных убеждений", "Профиль отношений", "Переживание перемен", "Самооценка", "Диагностика иррациональных установок, SPB", "Шкала базисных убеждений, WAS (Янов-Бульман)", "Тест профиля отношений, RPT (Борнстейн)", "Тест уверенности в себе (Ромек)", "Индикатор копинг-стратегий, CSI (Амирхан)", "Личностный опросник Айзенка, EPQ-RS", "Интегративный тест тревожности, ИТТ", "Шкала субъективного благополучия", "Опросник профессионального выгорания Маслач, MBI/ПВ"]
    var links = ["https://psytests.org/boyko/burnout-run.html", "https://psytests.org/psystate/spielberger.html", "https://psytests.org/projective/mili.html", "https://psytests.org/personal/ellis.html", "https://psytests.org/emotional/yanoff-run.html", "https://psytests.org/interpersonal/rpt.html", "https://psytests.org/coping/sacs.html", "https://psytests.org/emotional/ruvs.html", "ellis", "yanoff", "prt", "ruvs", "amirkhan", "epqRS", "itt", "bienetre", "maslach"]
    
    required init(view: PortraitViewProtocol) {
        self.view = view
    }

    func prepareCell(cell: SingleTestViewCell, index: Int) {
        cell.urlString = links[index]
        cell.testIndex = index
       
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier{
        case "customTestSegue":
            guard let vc = segue.destination as? CustomTestsViewController
            else {fatalError("invalid data passed")}
            vc.vcIndex = 0
            vc.testIndex = sender as? Int
            vc.presenter = CustomTestsPresenter(view: vc, questionIndex: 0, testIndex: (sender as? Int)!)
            
        default:
            break
        }
    }
    
    func getTitleText(index: Int) -> String {
        return tests[index]
    }
    
    func countData() -> Int {
        tests.count
    }

}

