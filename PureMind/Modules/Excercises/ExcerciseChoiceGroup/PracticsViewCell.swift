//
//  PracticsViewCell.swift
//  PureMind
//
//  Created by Клим on 07.10.2021.
//

import UIKit

class PracticsViewCell: UICollectionViewCell {
    
    static let identifier = "PracticsCell"
    var parentView: ExcerciseChoiceViewProtocol!
    var index: Int!
    
    @IBOutlet weak var openPracticButtonShell: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func openPracticButtonPressed(_ sender: Any) {
        parentView.excerciseChosen(index: index)
    }
}
