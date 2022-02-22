//
//  ShareViewController.swift
//  PureMind
//
//  Created by Клим on 29.01.2022.
//

import UIKit
import SafariServices

class ShareViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var backButtonShell: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var inviteButtonShell: UIButton!
    
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
        titleLabel.textColor = grayTextColor
        descriptionLabel.textColor = textFieldColor
        inviteButtonShell.layer.borderWidth = 1
        inviteButtonShell.layer.borderColor = lightYellowColor.cgColor
        inviteButtonShell.layer.cornerRadius = 15
        inviteButtonShell.tintColor = lightYellowColor
        inviteButtonShell.backgroundColor = UIColor(red: 255, green: 217, blue: 151).withAlphaComponent(0.24)
    }
    
    func openSafari(link: String){
        let safariVC = SFSafariViewController(url: URL(string: link)!)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func inviteButtonPressed(_ sender: Any) {
        let objectsToShare = URL(string: "https://testflight.apple.com/join/jGs5va9F")!
        let sharedObjects = [objectsToShare as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
