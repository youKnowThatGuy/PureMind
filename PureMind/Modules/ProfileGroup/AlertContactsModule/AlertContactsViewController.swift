//
//  AlertContactsViewController.swift
//  PureMind
//
//  Created by Клим on 02.02.2022.
//

import UIKit
import SafariServices

class AlertContactsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var planButtonShell: UIButton!
    @IBOutlet weak var callButtonShell: UIButton!
    @IBOutlet weak var internetButtonShell: UIButton!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background12")!)
        prepareViews()
    }
    
    func prepareViews(){
        topView.backgroundColor = .white
        topView.layer.cornerRadius = 20
        titleLabel.textColor = newButtonLabelColor
        descriptionLabel.textColor = newButtonLabelColor
        planButtonShell.tintColor = newButtonLabelColor
        planButtonShell.layer.borderWidth = 1
        planButtonShell.layer.borderColor = newButtonLabelColor.cgColor
        planButtonShell.backgroundColor = .white
        planButtonShell.layer.cornerRadius = 25
        planButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
        callButtonShell.tintColor = newButtonLabelColor
        callButtonShell.layer.borderWidth = 1
        callButtonShell.layer.borderColor = newButtonLabelColor.cgColor
        callButtonShell.backgroundColor = .white
        callButtonShell.layer.cornerRadius = 25
        callButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
        internetButtonShell.tintColor = newButtonLabelColor
        internetButtonShell.layer.borderWidth = 1
        internetButtonShell.layer.borderColor = newButtonLabelColor.cgColor
        internetButtonShell.backgroundColor = .white
        internetButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
        internetButtonShell.layer.cornerRadius = 25
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "safetyPlanSegue":
            guard let vc = segue.destination as? SafePlanViewController
            else {fatalError("invalid data passed")}
            vc.presenter = SafePlanPresenter(view: vc)
        default:
            break
        }
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    func openSafari(link: String){
        let safariVC = SFSafariViewController(url: URL(string: link)!)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func planButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "safetyPlanSegue", sender: nil)
    }
    
    @IBAction func callButtonPressed(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://8(800)333-44-34") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          }
    }
    
    @IBAction func internetButtonPressed(_ sender: Any) {
        openSafari(link: "http://telefon-doveriya.ru/#:~:text=%D0%91%D0%B5%D1%81%D0%BF%D0%BB%D0%B0%D1%82%D0%BD%D0%B0%D1%8F%20%D0%BA%D1%80%D0%B8%D0%B7%D0%B8%D1%81%D0%BD%D0%B0%D1%8F%20%D0%BB%D0%B8%D0%BD%D0%B8%D1%8F%20%D0%B4%D0%BE%D0%B2%D0%B5%D1%80%D0%B8%D1%8F.%20%D0%A2%D0%B5%D0%BB%D0%B5%D1%84%D0%BE%D0%BD%D1%8B,%D0%BF%D1%81%D0%B8%D1%85%D0%BE%D0%BB%D0%BE%D0%B3%D0%B0%20%D0%B2%20%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D0%B8%20%D0%B6%D0%B8%D0%B7%D0%BD%D0%B5%D0%BD%D0%BD%D1%8B%D1%85%20%D0%BF%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
