//
//  MenuViewController.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//

import UIKit
import DropDown

protocol MenuViewProtocol: UIViewController{
    func updateUI(collView: String)
}

class MenuViewController: UIViewController {
    var presenter: MenuPresenterProtocol!
    
    @IBOutlet weak var holderNameLabel: UILabel!
    @IBOutlet weak var chatButtonView: UIView!
    @IBOutlet weak var practicsCollectionView: UICollectionView!
    @IBOutlet weak var planCollectionView: UICollectionView!
    @IBOutlet weak var coursesCollectionView: UICollectionView!
    
    @IBOutlet weak var intervalButtonShell: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionViews()
        prepareChatButton()
        setupDropMenu(itemTitle: "Выбранный интервал ᐯ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
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
    
    func prepareChatButton(){
        chatButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToChatScreen)))
    }
    
    @objc func moveToChatScreen() {
        performSegue(withIdentifier: "chatSegue", sender: nil)
    }
    
    func prepareCollectionViews(){
        practicsCollectionView.delegate = self
        practicsCollectionView.dataSource = self
        
        planCollectionView.delegate = self
        planCollectionView.dataSource = self
        
        coursesCollectionView.delegate = self
        coursesCollectionView.dataSource = self
        
    }
    
    @IBAction func intervalButtonPressed(_ sender: Any) {
        menu.show()
    }
    
    @IBAction func moodButton1(_ sender: Any) {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Муд 1")
    }
    
    @IBAction func moodButton2(_ sender: Any) {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Муд 2")
    }
    
    @IBAction func moodButton3(_ sender: Any) {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Муд 3")
    }
    
    @IBAction func moodButton4(_ sender: Any) {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Муд 4")
    }
    
    @IBAction func moodButton5(_ sender: Any) {
        performSegue(withIdentifier: "moodFirstSegue", sender: "Муд 5")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    

}

extension MenuViewController: MenuViewProtocol{
    func updateUI(collView: String) {
        if collView == "PlanView"{
            planCollectionView.reloadData()
        }
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.practicsCollectionView{
            return 5
        }
        else if collectionView == self.planCollectionView{
            return 7
        }
        else{
          return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.practicsCollectionView{
            guard let cell = practicsCollectionView.dequeueReusableCell(withReuseIdentifier: PracticViewCell.identifier, for: indexPath) as? PracticViewCell
            else {fatalError("Invalid Cell kind")}
            presenter.preparePracticCell(cell: cell, index: indexPath.row)
            return cell
        }
        
        else if collectionView == self.planCollectionView{
            guard let cell = planCollectionView.dequeueReusableCell(withReuseIdentifier: PlanViewCell.identifier, for: indexPath) as? PlanViewCell
            else {fatalError("Invalid Cell kind")}
            presenter.preparePlanCell(cell: cell, index: indexPath.row)
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
