//
//  PracticViewCell.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//

import UIKit

class PracticViewCell: UICollectionViewCell {
    
    static let identifier = "PracticCell"
    
    var parentView: MenuViewProtocol!
    
    @IBOutlet weak var practicLabel: UILabel!
    @IBOutlet weak var excerciseCount: UILabel!
    
}
