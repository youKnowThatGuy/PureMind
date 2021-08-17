//
//  FirstQuestionsViewController.swift
//  PureMind
//
//  Created by Клим on 16.08.2021.
//

import UIKit

protocol FirstQuestionsViewProtocol: UIViewController{
    func updateUI()
    
    func loadQuestion(mood: String, questionTitle: String, questionDesc: String)
}

class FirstQuestionsViewController: UIViewController {
    var presenter: FirstQuestionsPresenterProtocol!
    var vcIndex: Int!
    
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var moodTitleLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionDescLabel: UILabel!
    @IBOutlet weak var answersCollectionView: UICollectionView!
    @IBOutlet weak var continueButtonShell: UIButton!
    @IBOutlet weak var backButtonShell: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        checkVCindex()
        presenter.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func checkVCindex(){
        backButtonShell.layer.cornerRadius = 15
        if vcIndex > 0{
            backButtonShell.isHidden = false
        }
    }
    
    func prepareCollectionView(){
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if vcIndex < 2 {
            let vc = ModuleBuilder().createMoodModuleOne(mood: presenter.currMood!, vcIndex: vcIndex + 1)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else{
            performSegue(withIdentifier: "moodSecondSegue", sender: presenter.currMood)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
    func inputOwnAnswer(index: IndexPath){
        let alert = UIAlertController(title: "Ваш ответ:", message: "", preferredStyle: .alert)
        
        let addlButton = UIAlertAction(title: "Добавить", style: .default){ (action) in
            let answer = alert.textFields![0].text!
            self.presenter.manageCustomAnswer(answer: answer, index: index)
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addTextField{(field) in field.placeholder = "..."}
        alert.addAction(addlButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}


extension FirstQuestionsViewController: FirstQuestionsViewProtocol{
    func loadQuestion(mood: String, questionTitle: String, questionDesc: String) {
        self.moodTitleLabel.text = mood
        self.questionDescLabel.text = "Описание вопроса №\(vcIndex + 1)"
        self.questionTitleLabel.text = "Вопрос №\(vcIndex + 1)"
    }
    
    func updateUI() {
        answersCollectionView.reloadData()
        if presenter.getSelectedAnswersCount() > 0{
            continueButtonShell.isUserInteractionEnabled = true
            continueButtonShell.backgroundColor = lightYellowColor
        }
        else{
            continueButtonShell.isUserInteractionEnabled = false
            continueButtonShell.backgroundColor = .none
        }
    }
}

extension FirstQuestionsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row >= presenter.getNumberOfItems(section: indexPath.section) - 1{
            inputOwnAnswer(index: indexPath)
        }
        else{
        guard let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: AnswerViewCell.identifier, for: indexPath) as? AnswerViewCell
        else {fatalError("Invalid Cell kind")}
        cell.answerNotChosen = !cell.answerNotChosen
        cell.backgroundColor = lightYellowColor
        presenter.manageAnswer(index: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewTitle.identifier, for: indexPath) as? CollectionViewTitle{
            sectionHeader.titleLabel.text = "Секция № \(indexPath.section + 1)"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.getNumberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getNumberOfItems(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: AnswerViewCell.identifier, for: indexPath) as? AnswerViewCell
        else {fatalError("Invalid Cell kind")}
        presenter.prepareCell(cell: cell, index: indexPath)
        return cell
    }
    
    
}
