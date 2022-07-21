//
//  DiaryPresenter.swift
//  PureMind
//
//  Created by Клим on 11.07.2022.
//

import UIKit

protocol DiaryPresenterProtocol{
    init(view: DiaryViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func prepareCell(cell: DiaryNoteCollectionViewCell, index: Int)
    func getData()
    func notesCount() -> Int
}

class DiaryPresenter: DiaryPresenterProtocol{
    weak var view: DiaryViewProtocol?
    
    var notes = [DiaryNote]()
    let dateFormatter = DateFormatter()
    
    required init(view: DiaryViewProtocol) {
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showMultipleDiarySegue":
            guard let vc = segue.destination as? MultipleChoiceDiaryViewController
            else {fatalError("invalid data passed")}
            vc.presenter = MultipleChoiceDiaryPresenter(view: vc, vcIndex: 0)
        default:
            break
        }
    }
    
    func prepareCell(cell: DiaryNoteCollectionViewCell, index: Int) {
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let note = notes[index]
        let date = NSDate(timeIntervalSince1970: TimeInterval(note.date))
        let stringDate = dateFormatter.string(from: date as Date)
        cell.dateLabel.text = stringDate
        cell.textLabel.text = note.text
        cell.titleLabel.text = note.theme
        cell.backgroundColor = UIColor(red: 253, green: 247, blue: 221)
        cell.dateLabel.textColor = lightYellowColor
        cell.textLabel.textColor = grayTextColor
        cell.titleLabel.textColor = UIColor(red: 254, green: 146, blue: 62)
        //cell.themeNameLabel.text = "Тема №\(index + 1)"
        cell.layer.cornerRadius = 15
    }
    
    func notesCount() -> Int {
        return notes.count
    }
    
    func getData() {
        CachingService.shared.getAllDiaryNotes { [weak self] (result) in
            self?.notes = result
            self?.view?.updateUI()
        }
    }
    
    
}
