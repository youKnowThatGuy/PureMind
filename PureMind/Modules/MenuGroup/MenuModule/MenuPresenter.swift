//
//  MenuPresenter.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//
import UIKit

protocol MenuPresenterProtocol{
    init(view: MenuViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func preparePracticCell(cell: PracticViewCell, index: Int)
    func preparePlanCell(cell: PlanViewCell, index: Int)
    func prepareCourseCell(cell: CourseViewCell, index: Int)
    func changeWeek(currWeek: String)
    func coursesCount() -> Int
}

class MenuPresenter: MenuPresenterProtocol{
    
    weak var view: MenuViewProtocol?
    
    var currWeek = "Неделя 1"
    var coursePurchased = true
    
    required init(view: MenuViewProtocol) {
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "chatSegue":
            guard let vc = segue.destination as? ChatViewController
            else {fatalError("invalid data passed")}
            vc.presenter = ChatPresenter(view: vc)
            
        case "moodFirstSegue":
            guard let vc = segue.destination as? QuestionsNavigationController
            else {fatalError("invalid data passed")}
            vc.currMood = sender as? String
            
        default:
            break
        }
    }
    
    func changeWeek(currWeek: String) {
        self.currWeek = currWeek
        view?.updateUI(collView: "PlanView")
    }
    
    
    func preparePlanCell(cell: PlanViewCell, index: Int) {
        cell.dayLabel.text = "День \(index + 1)"
        cell.weekLabel.text = currWeek
        cell.titleLabel.text = "План на сегодня"
        cell.availableImageView.isHidden = coursePurchased
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = blueBackgorundColor.cgColor
        
        cell.parentView = view
    }
    
    func prepareCourseCell(cell: CourseViewCell, index: Int) {
        cell.availableImageView.isHidden = false
        cell.courseLengthLabel.text = "\(index + 1 ) неделя"
        cell.courseNameLabel.text = "Курс №\(index + 1)"
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = blueBackgorundColor.cgColor
        
        cell.parentView = view
    }
    
    func preparePracticCell(cell: PracticViewCell, index: Int) {
        cell.practicImageView.image = UIImage(named: "noImage")
        cell.practicLabel.text = "Тема №\(index + 1)"
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = blueBackgorundColor.cgColor
        
        if index == 4{
            cell.practicLabel.text = "Все темы"
        }
        
        cell.parentView = view
    }
    
    
    func coursesCount() -> Int {
        //themes.count()
        return 12
    }
    
    
}
