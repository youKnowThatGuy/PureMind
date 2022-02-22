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
    func prepareCell(cell: ShortPolicyViewCell, index: Int)
    func getTitleText(index: Int) -> String
    func countData() -> Int
}

class PoliciesShortPresenter: PoliciesShortPresenterProtocol{
    weak var view: PoliciesShortViewProtocol?
    
    let data = ["Настоящая политика обработки персональных данных составлена в соответствии с требованиями Федерального закона от 27.07.2006. №152-ФЗ «О персональных данных» (далее - Закон о персональных данных) и определяет порядок обработки персональных данных и меры по обеспечению безопасности персональных данных, предпринимаемые Дёмин Константин Валерьевич (далее – Оператор).", "Субъекты персональных данных имеют право: получать информацию, касающуюся обработки его персональных данных, за исключением случаев, предусмотренных федеральными законами. Сведения предоставляются субъекту персональных данных Оператором в доступной форме, и в них не должны содержаться персональные данные, относящиеся к другим субъектам персональных данных, за исключением случаев, когда имеются законные основания для раскрытия таких персональных данных. Перечень информации и порядок ее получения установлен Законом о персональных данных;", "Оператор может обрабатывать следующие персональные данные Пользователя: Фамилия, имя, отчество; Электронный адрес; Информация о психологическом состоянии; Также на сайте происходит сбор и обработка обезличенных данных о посетителях (в т.ч. файлов «cookie») с помощью сервисов интернет-статистики (Яндекс Метрика и Гугл Аналитика и других).", "Принципы обработки персональных данных: Обработка персональных данных осуществляется на законной и справедливой основе; Обработка персональных данных ограничивается достижением конкретных, заранее определенных и законных целей. Не допускается обработка персональных данных, несовместимая с целями сбора персональных данных."]
    
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
    
    func prepareCell(cell: ShortPolicyViewCell, index: Int) {
        cell.descriptionLabel.text = data[index]
    }
    
    func getTitleText(index: Int) -> String {
        return "Правило №\(index + 1)"
    }
    
    func countData() -> Int {
        return data.count
    }
    
    
}

