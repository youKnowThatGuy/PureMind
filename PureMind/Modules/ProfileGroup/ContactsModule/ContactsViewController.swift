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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func prepareViews(){
        titleLabel.textColor = grayTextColor
        contactsView.layer.borderColor = lightBlueColor.cgColor
        contactsView.layer.borderWidth = 1
        contactsView.layer.cornerRadius = 15
        contactsView.backgroundColor = lightBlueColor.withAlphaComponent(0.24)
        instagramButtonShell.contentHorizontalAlignment = .left
        //instagramButtonShell.addBottomBorderWithColor(color: UIColor(red: 144, green: 191, blue: 255), width: 1)
        instagramButtonShell.tintColor = UIColor(red: 198, green: 222, blue: 255)
        telegramButtonShell.contentHorizontalAlignment = .left
        //telegramButtonShell.addBottomBorderWithColor(color: UIColor(red: 144, green: 191, blue: 255), width: 1)
        telegramButtonShell.tintColor = UIColor(red: 198, green: 222, blue: 255)
        callbackButtonShell.contentHorizontalAlignment = .left
        callbackButtonShell.tintColor = UIColor(red: 198, green: 222, blue: 255)
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
