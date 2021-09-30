//
//  TariffViewCell.swift
//  PureMind
//
//  Created by Клим on 12.09.2021.
//

import UIKit

class TariffViewCell: UICollectionViewCell {
    static let identifier = "tariffCell"
    
    @IBOutlet weak var recomendationLabel: UILabel!
    @IBOutlet weak var sessionsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var textLabelOne: UILabel!
    @IBOutlet weak var textLabelTwo: UILabel!
    @IBOutlet weak var continueButtonShell: UIButton!
    
    func prepareCellLayout(){
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        self.layer.borderColor = lightBlueColor.cgColor
        let labels = [priceLabel, textLabelOne, textLabelTwo]
        for label in labels{
            label?.textColor = grayTextColor
        }
        recomendationLabel.textColor = .white
        recomendationLabel.backgroundColor = lightBlueColor
        recomendationLabel.layer.cornerRadius = 15
        recomendationLabel.layer.masksToBounds = true
        recomendationLabel.layer.maskedCorners = [.layerMaxXMinYCorner]
        sessionsLabel.textColor = lightBlueColor
        continueButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        continueButtonShell.setTitleColor(.white, for: .normal)
        continueButtonShell.setTitle("Подтвердить", for: .normal)
        continueButtonShell.layer.cornerRadius = 15
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
    }
    
}
