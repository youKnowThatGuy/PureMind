//
//  ThemesPresenter.swift
//  PureMind
//
//  Created by Клим on 30.07.2021.
//

import UIKit

protocol ThemesPresenterProtocol{
    init(view: ThemesViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func prepareCell(cell: ThemeViewCell, index: Int)
    func themesCount() -> Int
    func selectedThemesCount() -> Int
    func manageTheme(index: Int)
}

class ThemesPresenter: ThemesPresenterProtocol{
    weak var view: ThemesViewProtocol?
    
    var themes = ["Тема №1", "Тема №2", "Тема №3", "Тема №4", "Тема №1", "Тема №2", "Тема №3", "Тема №4", "Тема №1", "Тема №2", "Тема №3", "Тема №4"]
    
    var selectedCells = [Int]()
    var selectedThemes = [String]()
    
    required init(view: ThemesViewProtocol) {
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "therapistChoiceSegue":
            guard let vc = segue.destination as? TherapistChoiceViewController
            else {fatalError("invalid data passed")}
            vc.presenter = TherapistChoicePresenter(view: vc)
            
        default:
            break
        }
    }
    
    func manageTheme(index: Int) {
        let check = selectedThemes.firstIndex(of: themes[index])
        if check == nil{
            selectedThemes.append(themes[index])
            selectedCells.append(index)
        }
        else{
            selectedThemes.remove(at: check!)
            let indexCell = selectedCells.firstIndex(of: index)
            selectedCells.remove(at: indexCell!)
        }
        view?.updateUI()
    }
    
    func prepareCell(cell: ThemeViewCell, index: Int) {
        let check = selectedCells.firstIndex(of: index)
        if check == nil{
            cell.backgroundColor = toxicYellow
        }
        else{
            cell.backgroundColor = toxicYellowSelected
        }
        cell.themeNameLabel.text = "Тема №\(index + 1)"
        cell.layer.cornerRadius = 15
    }
    
    func selectedThemesCount() -> Int {
        selectedThemes.count
    }
    
    func themesCount() -> Int {
        //themes.count()
        return 12
    }
    
    
}
