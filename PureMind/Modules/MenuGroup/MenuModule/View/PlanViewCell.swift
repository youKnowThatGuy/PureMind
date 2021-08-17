//
//  PlanViewCell.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//

import UIKit

class PlanViewCell: UICollectionViewCell {
    static let identifier = "PlanCell"
    var parentView: MenuViewProtocol!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var availableImageView: UIImageView!
    
    @IBAction func planStartPressed(_ sender: Any) {
    }
    
    
}
