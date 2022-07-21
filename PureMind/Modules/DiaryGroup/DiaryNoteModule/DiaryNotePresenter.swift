//
//  DiaryNotePresenter.swift
//  PureMind
//
//  Created by Клим on 11.07.2022.
//

import UIKit

protocol DiaryNotePresenterProtocol{
    init(view: DiaryNoteViewProtocol)
}

class DiaryPresenter: DiaryNotePresenterProtocol{
    weak var view: DiaryNoteViewProtocol?
    
    var themes = ["Тема №1", "Тема №2", "Тема №3", "Тема №4", "Тема №1", "Тема №2", "Тема №3", "Тема №4", "Тема №1", "Тема №2", "Тема №3", "Тема №4"]
    
    
    required init(view: DiaryNoteViewProtocol) {
        self.view = view
    }
    
}
