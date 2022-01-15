//
//  MenuViewController.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//

import UIKit
import DropDown

protocol MenuViewProtocol: UIViewController{
    func updateUI()
}

class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol!
    
    @IBOutlet weak var holderNameLabel: UILabel!
    @IBOutlet weak var practicsTitleLabel: UILabel!
    @IBOutlet weak var chatButtonView: UIView!
    @IBOutlet weak var practicsCollectionView: UICollectionView!
    @IBOutlet weak var coursesCollectionView: UICollectionView!
    @IBOutlet weak var practicsTitleButtonShell: UIButton!
    @IBOutlet weak var moodTitleLabel: UILabel!
    @IBOutlet weak var moodQuestionLabel: UILabel!
    @IBOutlet weak var moodView: UIView!
    @IBOutlet weak var moodLabel1: UILabel!
    @IBOutlet weak var moodLabel2: UILabel!
    @IBOutlet weak var moodLabel3: UILabel!
    @IBOutlet weak var moodLabel4: UILabel!
    @IBOutlet weak var moodLabel5: UILabel!
    @IBOutlet weak var moodView1: UIView!
    @IBOutlet weak var moodView2: UIView!
    @IBOutlet weak var moodView3: UIView!
    @IBOutlet weak var moodView4: UIView!
    @IBOutlet weak var moodView5: UIView!
    @IBOutlet weak var coursesTitleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionViews()
        prepareButtons()
        prepareDesign()
        presenter.loadData()
    }
    
    func prepareDesign(){
        holderNameLabel.backgroundColor = lightYellowColor
        holderNameLabel.layer.masksToBounds = true
        holderNameLabel.layer.cornerRadius = 20
        coursesTitleLabel.textColor = grayTextColor
        chatButtonView.backgroundColor = lightYellowColor
        chatButtonView.layer.cornerRadius = 20
        practicsTitleLabel.textColor = grayTextColor
        moodTitleLabel.textColor = grayTextColor
        moodQuestionLabel.textColor = grayTextColor
        practicsTitleButtonShell.setTitleColor(lightYellowColor, for: .normal)
        practicsTitleButtonShell.layer.cornerRadius = 10
        practicsTitleButtonShell.layer.borderColor = lightYellowColor.cgColor
        practicsTitleButtonShell.layer.borderWidth = 1
        practicsTitleButtonShell.layer.masksToBounds = true
            /*
        intervalButtonShell.setTitleColor(lightYellowColor, for: .normal)
        intervalButtonShell.layer.cornerRadius = 10
        intervalButtonShell.layer.borderColor = lightYellowColor.cgColor
        intervalButtonShell.layer.borderWidth = 1
        intervalButtonShell.layer.masksToBounds = true
        planTitleLabel.textColor = grayTextColor
 */
        moodView.layer.cornerRadius = 12
        moodView.layer.borderColor = lightBlueColor.cgColor
        moodLabel1.textColor = UIColor(red: 144, green: 191, blue: 255)
        moodLabel2.textColor = UIColor(red: 199, green: 225, blue: 179)
        moodLabel3.textColor = UIColor(red: 252, green: 212, blue: 0)
        moodLabel4.textColor = UIColor(red: 252, green: 177, blue: 120)
        moodLabel5.textColor = UIColor(red: 249, green: 117, blue: 96)
        moodView.layer.cornerRadius = 12
        moodView.layer.borderColor = lightBlueColor.cgColor
        moodView.layer.borderWidth = 2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    /*
    func setupDropMenu(itemTitle: String){
        intervalButtonShell.setTitle(itemTitle, for: .normal)
        menu.anchorView = intervalButtonShell
        menu.selectionAction = { index, title in
            switch index {
            case 0:
                self.intervalButtonShell.setTitle("Неделя 1", for: .normal)
                self.presenter.changeWeek(currWeek: "Неделя 1")
            case 1:
                self.intervalButtonShell.setTitle("Неделя 2", for: .normal)
                self.presenter.changeWeek(currWeek: "Неделя 2")
            case 2:
                self.intervalButtonShell.setTitle("Неделя 3", for: .normal)
                self.presenter.changeWeek(currWeek: "Неделя 3")
            case 3:
                self.intervalButtonShell.setTitle("Неделя 4", for: .normal)
                self.presenter.changeWeek(currWeek: "Неделя 4")
            default:
                fatalError()
            }
            
        }
    }
 */
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["Неделя 1/4", "Неделя 2/4", "Неделя 3/4", "Неделя 4/4"]
        menu.cellNib = UINib(nibName: "MenuCell", bundle: nil)
        menu.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MenuCell else{
                return
            }
        }
        return menu
    }()
    
    func prepareButtons(){
        chatButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToChatScreen)))
        moodView1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moodButton1)))
        moodView2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moodButton2)))
        moodView3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moodButton3)))
        moodView4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moodButton4)))
        moodView5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moodButton5)))
    }
    
    @objc func moveToChatScreen() {
        performSegue(withIdentifier: "chatSegue", sender: nil)
    }
    
    func prepareCollectionViews(){
        practicsCollectionView.delegate = self
        practicsCollectionView.dataSource = self
        coursesCollectionView.delegate = self
        coursesCollectionView.dataSource = self
    }
    
    @IBAction func practicsTitleButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func intervalButtonPressed(_ sender: Any) {
        menu.show()
    }
    
    @objc func moodButton1() {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Отлично")
    }
    
    @objc func moodButton2() {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Хорошо")
    }
    
    @objc func moodButton3() {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Нормально")
    }
    
    @objc func moodButton4() {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Плохо")
    }
    
    @objc func moodButton5() {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Ужасно")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    

}


extension MenuViewController: MenuViewProtocol{
    func updateUI() {
        practicsCollectionView.reloadData()
        coursesCollectionView.reloadData()
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.practicsCollectionView{
            if indexPath.row == collectionView.numberOfItems(inSection: 0) - 1{
                performSegue(withIdentifier: "allPracticsSegue", sender: nil)
            }
            else{
            performSegue(withIdentifier: "excercisesChoiceSegue", sender: indexPath.row)
            }
        }
        else{
          
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.practicsCollectionView{
            return presenter.practicsCount()
        }
        else{
            return presenter.coursesCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.practicsCollectionView{
            guard let cell = practicsCollectionView.dequeueReusableCell(withReuseIdentifier: PracticViewCell.identifier, for: indexPath) as? PracticViewCell
            else {fatalError("Invalid Cell kind")}
            presenter.preparePracticCell(cell: cell, index: indexPath.row)
            return cell
        }
        
        else{
            guard let cell = coursesCollectionView.dequeueReusableCell(withReuseIdentifier: CourseViewCell.identifier, for: indexPath) as? CourseViewCell
            else {fatalError("Invalid Cell kind")}
            presenter.prepareCourseCell(cell: cell, index: indexPath.row)
            return cell
        }
    }
}
