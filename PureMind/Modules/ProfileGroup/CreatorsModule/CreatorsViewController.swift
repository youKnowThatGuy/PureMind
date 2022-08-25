//
//  CreatorsViewController.swift
//  PureMind
//
//  Created by Клим on 30.01.2022.
//

import UIKit

class CreatorsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var titleLabel3: UILabel!
    @IBOutlet weak var descriptionLabel1: UILabel!
    @IBOutlet weak var descriptionLabel2: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background12")!)
        self.view.addGestureRecognizer(swipeLeft)
        prepareViews()
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    func prepareViews(){
        backView.backgroundColor = .clear
        titleLabel.textColor = newButtonLabelColor
        titleLabel2.textColor = newButtonLabelColor
        titleLabel3.textColor = newButtonLabelColor
        descriptionLabel1.textColor = newButtonLabelColor
        descriptionLabel2.textColor = newButtonLabelColor
        descriptionView.textColor = newButtonLabelColor
        topView.backgroundColor = .white
        topView.layer.cornerRadius = 20

    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
