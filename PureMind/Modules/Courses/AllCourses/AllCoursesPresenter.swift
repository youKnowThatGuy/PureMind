//
//  AllCoursesPresenter.swift
//  PureMind
//
//  Created by Клим on 16.01.2022.
//

import UIKit

protocol AllCoursesPresenterProtocol{
    init(view: AllCoursesViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func prepareCell(cell: SingleCourseViewCell, index: Int)
    func getTitleText(index: Int) -> String
    func countData() -> Int
}

class AllCoursesPresenter: AllCoursesPresenterProtocol{
    weak var view: AllCoursesViewProtocol?
    let networkService = NetworkService.shared
    var currExcercises = [CoursesInfo]()
    var courses = ["Страх", "Стыд", "Обида", "Уверенность", "Апатия", "Вина", "Злость", "Стресс"]
    
    required init(view: AllCoursesViewProtocol) {
        self.view = view
        networkService.getCourses { [weak self] (result) in
            switch result{
            case let .success(tokens):
                for token in tokens {
                    self?.currExcercises.append(token)
                    self?.view?.updateUI()
                    
                }
                
            case .failure(_):
                self?.view?.failedToLoad()
            }
        }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "practicChosenSegue":
            guard let vc = segue.destination as? PageExcerciseViewController, let string = sender as? [String]
            else {fatalError("invalid data passed")}
            vc.info = string
            
        default:
            break
        }
    }

    func prepareCell(cell: SingleCourseViewCell, index: Int) {
        let group = courses[index]
        var mas = [PracticesInfo]()
        /*
        for exc in currExcercises {
            if exc.category == group{
                mas.append(exc)
            }
        }
 */
        cell.excercises = mas
        cell.parentVC = view
        cell.lessonsTableView.reloadData()
    }
    
    func getTitleText(index: Int) -> String {
        return courses[index]
    }
    
    func countData() -> Int {
        courses.count
    }

}
