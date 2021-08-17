//
//  TherapistChoiceViewController.swift
//  PureMind
//
//  Created by Клим on 31.07.2021.
//

import UIKit

protocol TherapistChoiceViewProtocol: UIViewController{
    func updateUI()
}

class TherapistChoiceViewController: UIViewController {
    
    var presenter: TherapistChoicePresenterProtocol!
    
    @IBOutlet weak var soloChoiceView: UIView!
    
    @IBOutlet weak var therapistChoiceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soloChoiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performSegueFromFirstView)))
        therapistChoiceView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performSegueFromSecondView)))
        
    }
    
    @objc func performSegueFromFirstView(){
        performSegue(withIdentifier: "registrationToMenuSeuge", sender: nil)
    }
    
    
    @objc func performSegueFromSecondView(){
        performSegue(withIdentifier: "therapistSubSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: nil)
    }
    

}

extension TherapistChoiceViewController: TherapistChoiceViewProtocol{
    func updateUI() {
        print("Good!")
    }
    
    
}
