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
    var textArray = ["Используйте терапевтический чат, чтобы восстановить свое состояние в моменте: при панической атаке, приступе тревоги или в других сложных ситуациях.", "Здесь мы собрали сотни проверенных упражнений по переживанию и проработке эмоций. Улучшите свое состояние, выбрав подходящую категорию: гнев, застенчивость, тревога и т.д.", "Нет возможности посещать психолога, но чувствуете потребность в психотерапии? Наши курсы могут стать отличной альтернативой. Лекции от психологов, домашние задания с обратной связью, постановка целей и отслеживание прогресса - все это ждет Вас на нашей платформе.", "Измените образ мышления с помощью дневников, разработанных специалистами. Путем анализа ситуаций и выявления негативных убеждений - вы сможете привлечь в свою жизнь положительные изменения."]
    var titleArray = ["Терапевтический чат", "Практики", "Курсы", "Дневники"]
    
    required init(view: DescriptionViewProtocol) {
        self.view = view
    }
    
    func cardCount() -> Int {
        textArray.count
    }
    
    func prepareCell(cell: CardViewCell, index: Int) {
        cell.titleLabel.text = titleArray[index]
        cell.titleLabel.textColor = grayTextColor
        cell.cardImage.image = UIImage(named: "illustration\(index + 1)")
        cell.mainTextLabel.text = textArray[index]
        cell.mainTextLabel.textColor = grayTextColor
        
        cell.backgroundColor = .white
        cell.contentView.layer.cornerRadius = 30
        cell.layer.cornerRadius = 30
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
