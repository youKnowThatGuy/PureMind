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
    @IBOutlet weak var topView: UIView!
    
    
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
        topView.backgroundColor = .white
        topView.layer.cornerRadius = 20
        titleLabel.textColor = newButtonLabelColor
        descriptionLabel.textColor = newButtonLabelColor
        inviteButtonShell.setTitleColor(.white, for: .normal)
        inviteButtonShell.layer.cornerRadius = 20
        inviteButtonShell.backgroundColor = newButtonLabelColor
        
    }
    
    func openSafari(link: String){
        let safariVC = SFSafariViewController(url: URL(string: link)!)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func inviteButtonPressed(_ sender: Any) {
        let objectsToShare = URL(string: "https://apps.apple.com/ru/app/puremind-app/id1608188398")!
        let sharedObjects = [objectsToShare as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
