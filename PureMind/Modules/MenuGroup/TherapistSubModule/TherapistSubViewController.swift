//
//  TherapistSubViewController.swift
//  PureMind
//
//  Created by Клим on 31.07.2021.
//

import UIKit

class TherapistSubViewController: UIViewController {
    
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel1: UILabel!
    @IBOutlet weak var descLabel2: UILabel!
    @IBOutlet weak var descLabel3: UILabel!
    @IBOutlet weak var continueButtonShell: UIButton!
    
    @IBOutlet weak var therapistView: UIView!
    @IBOutlet weak var therapistTitle: UILabel!
    @IBOutlet weak var therapistPriceLabel: UILabel!
    @IBOutlet weak var therapistButtonShell: UIButton!
    
    var backButtonHidden = false
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }
    
    func prepareViews(){
        backButtonShell.isHidden = backButtonHidden
        therapistView.layer.cornerRadius = 15
        therapistView.layer.borderWidth = 2
        therapistView.layer.borderColor = lightBlueColor.cgColor
        
        let labels = [titleLabel, descLabel1, descLabel2, descLabel3, therapistTitle]
        backButtonShell.tintColor = lightYellowColor
        for label in labels{
            label?.textColor = grayTextColor
        }
        therapistPriceLabel.textColor = lightBlueColor
        
        therapistButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        therapistButtonShell.setTitleColor(.white, for: .normal)
        therapistButtonShell.setTitle("Подтвердить", for: .normal)
        therapistButtonShell.layer.cornerRadius = 15
        
        continueButtonShell.layer.borderWidth = 2
        continueButtonShell.layer.cornerRadius = 15
        continueButtonShell.layer.borderColor = lightYellowColor.cgColor
        continueButtonShell.setTitleColor(grayButtonColor, for: .normal)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
 
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "registrationToMenuSegue2", sender: nil)
        
    }
    
    @IBAction func therpistButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "therapistPricesSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "therapistPricesSegue":
            guard let vc = segue.destination as? TherapistPriceViewController
            else {fatalError("invalid data passed")}
            vc.presenter = TherapistPricePresenter(view: vc)
        
        case "registrationToMenuSegue2":
            guard segue.destination is MainTabBarController
            else {fatalError("invalid data passed")}
            
        default:
            break
        }
    }
}
