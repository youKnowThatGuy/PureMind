//
//  WelcomeViewController.swift
//  PureMind
//
//  Created by Клим on 06.07.2021.
//

import UIKit


class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = darkGrayTextColor
        buttonOutlet.tintColor = lightYellowColor
        textLabel.textColor = grayTextColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func welcomeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "descriptionSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "descriptionSegue":
            guard let vc = segue.destination as? DescriptionViewController
            else {fatalError("invalid data passed")}
            vc.presenter = DescriptionPresenter(view: vc)
            
        default:
            break
        }
    }
    

}
