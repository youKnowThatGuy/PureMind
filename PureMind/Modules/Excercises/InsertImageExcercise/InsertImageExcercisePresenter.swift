//
//  InsertImageExcercisePresenter.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import Foundation

protocol InsertImageExcercisePresenterProtocol{
    init(view: InsertImageExcerciseViewProtocol, currAudio: String?)
    func loadAudio()
}

class InsertImageExcercisePresenter: InsertImageExcercisePresenterProtocol{
    
    
    weak var view: InsertImageExcerciseViewProtocol?
    var audioId: String?
    
    required init(view: InsertImageExcerciseViewProtocol, currAudio: String?) {
        self.view = view
        if currAudio != nil{
            audioId = currAudio
        }
    }
    
    func loadAudio(){
        if audioId != nil{
            NetworkService.shared.getAudio(audioId: audioId!) {[weak self] (result) in
                switch result{
                case .failure(_):
                    self?.view?.failedToLoad()
                case let .success(data):
                    self?.view?.updateUI(audioData: data)
                }
            }
        }
        else{
            view?.failedToLoad()
        }
    }
    
}
