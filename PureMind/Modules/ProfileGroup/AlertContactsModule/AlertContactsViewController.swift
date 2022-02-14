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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }
    
    func prepareViews(){
        titleLabel.textColor = grayTextColor
        descriptionLabel.textColor = textFieldColor
        planButtonShell.tintColor = titleBlueColor
        planButtonShell.layer.borderWidth = 1
        planButtonShell.layer.borderColor = titleBlueColor.cgColor
        planButtonShell.backgroundColor = titleBlueColor.withAlphaComponent(0.24)
        planButtonShell.layer.cornerRadius = 15
        callButtonShell.tintColor = titleBlueColor
        callButtonShell.layer.borderWidth = 1
        callButtonShell.layer.borderColor = titleBlueColor.cgColor
        callButtonShell.backgroundColor = titleBlueColor.withAlphaComponent(0.24)
        callButtonShell.layer.cornerRadius = 15
        internetButtonShell.tintColor = titleBlueColor
        internetButtonShell.layer.borderWidth = 1
        internetButtonShell.layer.borderColor = titleBlueColor.cgColor
        internetButtonShell.backgroundColor = titleBlueColor.withAlphaComponent(0.24)
        internetButtonShell.layer.cornerRadius = 15
    }
    
    func openSafari(link: String){
        let safariVC = SFSafariViewController(url: URL(string: link)!)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func planButtonPressed(_ sender: Any) {
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
