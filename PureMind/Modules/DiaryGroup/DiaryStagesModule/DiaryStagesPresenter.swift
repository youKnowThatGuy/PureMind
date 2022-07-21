//
//  DiaryStagesPresenter.swift
//  PureMind
//
//  Created by Клим on 20.07.2022.
//

import UIKit

protocol DiaryStagesPresenterProtocol{
    init(view: DiaryStagesViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func getTitleText(index: Int) -> String
    func getData()
    func stagesCount() -> Int
}

class DiaryStagesPresenter: DiaryStagesPresenterProtocol{
    weak var view: DiaryStagesViewProtocol?
    
    var stages = ["Вопросы на каждый день", "Аффирмации", "Дневник настроения", "Перед сном 1.0", "Вечернее планирование", "Перед сном 2.0", "Утренний дневник"]
    let dateFormatter = DateFormatter()
    
    required init(view: DiaryStagesViewProtocol) {
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "everydayNoteSegue":
            guard let vc = segue.destination as? EverydayNoteViewController, let flag = sender as? Bool
            else {fatalError("invalid data passed")}
            vc.typeFlag = flag
            
        case "showDiaryNotesSegue":
            guard let vc = segue.destination as? DiaryViewController
            else {fatalError("invalid data passed")}
            vc.presenter = DiaryPresenter(view: vc)
            
        case "showDiaryTextSegue":
            guard let vc = segue.destination as? DiaryTextViewController, let stringArray = sender as? [String]
            else {fatalError("invalid data passed")}
            vc.titleText = stringArray[0]
            vc.mainText = stringArray[1]
            
        default:
            break
        }
    }
    
    func getTitleText(index: Int) -> String {
        return stages[index]
    }
    
    func stagesCount() -> Int {
        return stages.count
    }
    
    func getData() {
        CachingService.shared.getAllDiaryNotes { [weak self] (result) in
            //self?.notes = result
            self?.view?.updateUI()
        }
    }
    
    
}
