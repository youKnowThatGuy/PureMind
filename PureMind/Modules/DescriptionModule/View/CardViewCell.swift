//
//  CardViewCell.swift
//  PureMind
//
//  Created by Клим on 07.07.2021.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    static let identifier = "cardCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
}
