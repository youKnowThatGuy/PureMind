//
//  AllExcercisePresenter.swift
//  PureMind
//
//  Created by Клим on 03.01.2022.
//

import UIKit

protocol AllExcercisePresenterProtocol{
    init(view: AllExcerciseViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func prepareCell(cell: ExcercisesViewCell, index: Int)
    func getTitleText(index: Int) -> String
    func countData() -> Int
}

class AllExcercisePresenter: AllExcercisePresenterProtocol{
    weak var view: AllExcerciseViewProtocol?
    let networkService = NetworkService.shared
    var currExcercises = [PracticesInfo]()
    var practics = ["Страх", "Стыд", "Обида", "Уверенность", "Апатия", "Вина", "Злость", "Стресс"]
    
    required init(view: AllExcerciseViewProtocol) {
        self.view = view
        networkService.getPractices { [weak self] (result) in
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

    func prepareCell(cell: ExcercisesViewCell, index: Int) {
        let group = practics[index]
        var mas = [PracticesInfo]()
        for exc in currExcercises {
            if exc.category == group{
                mas.append(exc)
            }
        }
        cell.excercises = mas
        cell.parentVC = view
        cell.excercisesTableView.reloadData()
    }
    
    func getTitleText(index: Int) -> String {
        return practics[index]
    }
    
    func countData() -> Int {
        practics.count
    }

}
