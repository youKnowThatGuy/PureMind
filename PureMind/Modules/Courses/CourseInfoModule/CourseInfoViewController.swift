//
//  CourseInfoViewController.swift
//  PureMind
//
//  Created by Клим on 06.02.2022.
//

import UIKit

class CourseInfoViewController: UIViewController {

    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseDescription: UITextView!
    
    var titleText = ""
    var courseDescriptionText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseTitleLabel.text = titleText
        courseDescription.text = courseDescriptionText
        courseTitleLabel.textColor = grayTextColor
        courseDescription.textColor = grayTextColor
    }

}
