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
    @IBOutlet weak var titleLabel4: UILabel!
    @IBOutlet weak var descriptionLabel1: UILabel!
    @IBOutlet weak var descriptionLabel2: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        prepareViews()
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    func prepareViews(){
        backView.backgroundColor = titleBlueColor.withAlphaComponent(0.24)
        backView.layer.borderColor = titleBlueColor.cgColor
        backView.layer.borderWidth = 1
        titleLabel.textColor = grayTextColor
        titleLabel2.textColor = titleBlueColor
        titleLabel3.textColor = titleBlueColor
        titleLabel4.textColor = titleBlueColor
        descriptionLabel1.textColor = textFieldColor
        descriptionLabel2.textColor = textFieldColor
        descriptionView.textColor = textFieldColor


    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
