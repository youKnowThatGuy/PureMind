//
//  AnswerViewCell.swift
//  PureMind
//
//  Created by Клим on 16.08.2021.
//

import UIKit

class AnswerViewCell: UICollectionViewCell {
    static let identifier = "AnswerCell"
    var answerNotChosen = true
    @IBOutlet weak var textLabel: UILabel!
}
