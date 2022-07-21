//
//  NotificationsChoicePresenter.swift
//  PureMind
//
//  Created by Клим on 03.07.2022.
//

import UIKit

protocol NotificationsChoicePresenterProtocol{
    init(view: NotificationsChoiceViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func optionsCount() -> Int
    func manageOpt(index: Int) 
    func prepareCell(cell: OptionCollectionViewCell, index: Int)
}

class NotificationsChoicePresenter: NotificationsChoicePresenterProtocol{
    weak var view: NotificationsChoiceViewProtocol?
    var currMood: String?
    var options = ["Привычка №1", "Привычка №2", "Привычка №3", "Привычка №4", "Привычка №5", "Привычка №6", "Привычка №7" ]
    
    var selectedCells = [Int]()
    var selectedOpts = [String]()
    
    required init(view: NotificationsChoiceViewProtocol) {
        self.view = view
    }
    
    func optionsCount() -> Int{
        return 7
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "moodExcSegue":
            guard let vc = segue.destination as? ExcerciseChoiceViewController, let index = sender as? Int
            else {fatalError("invalid data passed")}
            let string = options[index]
            vc.presenter = ExcerciseChoicePresenter(view: vc, currPractic: string)
            
        default:
            break
        }
    }
    
    func prepareCell(cell: OptionCollectionViewCell, index: Int){
        let check = selectedCells.firstIndex(of: index)
        if check == nil{
            cell.backgroundColor = UIColor.white
        }
        else{
            cell.backgroundColor = lightYellowColor
        }
        
        cell.titleLabel.text = options[index]
        cell.titleLabel.textColor = grayTextColor
        cell.descLabel.text = "Что-то там"
        cell.descLabel.textColor = UIColor(red: 175, green: 175, blue: 175)
        cell.iconImageView.image = UIImage(named: "тик")
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = lightYellowColor.cgColor
        cell.layer.borderWidth = 1
    }
    
    func manageOpt(index: Int) {
        let check = selectedOpts.firstIndex(of: options[index])
        if check == nil{
            selectedOpts.append(options[index])
            selectedCells.append(index)
        }
        else{
            selectedOpts.remove(at: check!)
            let indexCell = selectedCells.firstIndex(of: index)
            selectedCells.remove(at: indexCell!)
        }
        view?.updateUI()
    }
    
}
