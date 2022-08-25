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
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [UIColor(red: 239, green: 243, blue: 255),
        UIColor(red: 255, green: 252, blue: 250)]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = newButtonLabelColor
        buttonOutlet.tintColor = newButtonLabelColor
        textLabel.textColor = newButtonLabelColor
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
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
