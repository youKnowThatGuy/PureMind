//
//  EverydayNoteViewController.swift
//  PureMind
//
//  Created by Клим on 20.07.2022.
//

import UIKit

class EverydayNoteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var readyButtonShell: UIButton!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteBackgroundView: UIView!
    var typeFlag = false
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background3")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    }
    
    func prepareViews(){
        titleLabel.text = "Аффирмации"
        if typeFlag == true{
            titleLabel.text = "Вопросы на каждый день"
        }
        titleLabel.textColor = .white
        readyButtonShell.setTitleColor(.white, for: .normal)
        readyButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        readyButtonShell.layer.cornerRadius = 15
        noteBackgroundView.backgroundColor = UIColor(red: 253, green: 247, blue: 221)
        noteLabel.textColor = grayTextColor
        imageView.isUserInteractionEnabled = true
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func readyButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
