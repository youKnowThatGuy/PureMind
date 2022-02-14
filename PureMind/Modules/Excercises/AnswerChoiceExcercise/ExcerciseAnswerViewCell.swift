//
//  ExcerciseAnswerViewCell.swift
//  PureMind
//
//  Created by Клим on 22.01.2022.
//

import UIKit

class ExcerciseAnswerViewCell: UICollectionViewCell {
    static let identifier = "ExcerciseAnswerCell"
    var answerNotChosen = true
    var index: Int!
    weak var parentPresenter: AnswerChoiceExcercisePresenter?
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var choiceButtonShell: UIButton!
    
    @IBAction func choiceButtonPressed(_ sender: Any) {
        parentPresenter?.manageAnswer(index: index)
    }
}
