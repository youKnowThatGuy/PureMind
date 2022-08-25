//
//  ContactsViewController.swift
//  PureMind
//
//  Created by Клим on 02.02.2022.
//

import UIKit
import SafariServices
import MessageUI

class ContactsViewController: UIViewController, SFSafariViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contactsView: UIView!
    @IBOutlet weak var instagramButtonShell: UIButton!
    @IBOutlet weak var telegramButtonShell: UIButton!
    @IBOutlet weak var callbackButtonShell: UIButton!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background12")!)
        prepareViews()
    }
    
    @objc func handleGesture(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func prepareViews(){
        topView.layer.cornerRadius = 20
        topView.backgroundColor = .white
        titleLabel.textColor = newButtonLabelColor
        contactsView.layer.borderColor = lightBlueColor.cgColor
        contactsView.layer.borderWidth = 1
        contactsView.layer.cornerRadius = 15
        contactsView.backgroundColor = .white
        instagramButtonShell.contentHorizontalAlignment = .left
        //instagramButtonShell.addBottomBorderWithColor(color: UIColor(red: 144, green: 191, blue: 255), width: 1)
        instagramButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
        telegramButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
        callbackButtonShell.contentHorizontalAlignment = .left
        callbackButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
    }
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["Puremindapp123@gmail.com "])
        mailComposeVC.setSubject("")
        mailComposeVC.setMessageBody("", isHTML: false)
        return mailComposeVC
    }
    
    func openSafari(link: String){
        let safariVC = SFSafariViewController(url: URL(string: link)!)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func instagramButtonPressed(_ sender: Any) {
        openSafari(link: "https://instagram.com/puremind.app?utm_medium=copy_link")
    }
    
    @IBAction func telegramButtonPressed(_ sender: Any) {
        openSafari(link: "http://telegram.me/PureMindBot")
    }
    
    @IBAction func callbackButtonPressed(_ sender: Any) {
        let mailComposeViewController = configureMailComposer()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
                print("Can't send email")
            }
    }
    
}
