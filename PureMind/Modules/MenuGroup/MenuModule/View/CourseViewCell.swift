//
//  CourseViewCell.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//

import UIKit

class CourseViewCell: UICollectionViewCell {
    static let identifier = "CourseCell"
    var parentView: MenuViewProtocol!
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var availableImageView: UIImageView!
    
    @IBOutlet weak var courseLengthLabel: UILabel!
    
    @IBAction func courseStartPressed(_ sender: Any) {
    }
    
}
