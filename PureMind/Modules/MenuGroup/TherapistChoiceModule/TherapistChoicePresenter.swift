//
//  TherapistChoicePresenter.swift
//  PureMind
//
//  Created by Клим on 31.07.2021.
//

import UIKit



protocol TherapistChoicePresenterProtocol{
    init(view: TherapistChoiceViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class TherapistChoicePresenter: TherapistChoicePresenterProtocol{
    weak var view: TherapistChoiceViewProtocol?
    
    
    required init(view: TherapistChoiceViewProtocol) {
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "therapistSubSegue":
            guard let _ = segue.destination as? TherapistSubViewController
            else {fatalError("invalid data passed")}
            //vc.presenter = TherapistChoicePresenter(view: vc)
        
        case "registrationToMenuSeuge":
            guard segue.destination is MainTabBarController
            else {fatalError("invalid data passed")}
            
        default:
            break
        }
    }

    
    
}
