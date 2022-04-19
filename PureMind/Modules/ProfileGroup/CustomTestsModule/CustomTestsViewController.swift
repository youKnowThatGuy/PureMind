//
//  CustomTestsViewController.swift
//  PureMind
//
//  Created by Клим on 11.04.2022.
//

import UIKit

protocol CustomTestsViewProtocol: UIViewController{
    func updateUI()
    func loadQuestion(questionTitle: String, questionDesc: String)
}

class CustomTestsViewController: UIViewController {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionDescLabel: UILabel!
    @IBOutlet weak var answersCollectionView: UICollectionView!
    @IBOutlet weak var backButtonShell: UIButton!
    
    var presenter: CustomTestsPresenterProtocol!
    var vcIndex: Int!
    var totalScore = [Double]()
    var testIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLabels()
        view.backgroundColor = perfectMood
        presenter.loadTest(questionIndex: vcIndex)
        prepareCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func prepareLabels(){
        questionTitleLabel.textColor = .white
        questionDescLabel.textColor = .white
        backButtonShell.tintColor = titleYellow
    }
    
    func prepareCollectionView(){
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension CustomTestsViewController: CustomTestsViewProtocol{
    
    func loadQuestion(questionTitle: String, questionDesc: String) {
        self.questionTitleLabel.text = "Вопрос №\(vcIndex + 1)"
        self.questionDescLabel.text = questionTitle
    }
    
    
    func updateUI() {
        answersCollectionView.reloadData()
    }
}

extension CustomTestsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: AnswerViewCell.identifier, for: indexPath) as? AnswerViewCell
        else {fatalError("Invalid Cell kind")}
        cell.answerNotChosen = !cell.answerNotChosen
        if vcIndex < presenter.finishIndex {  // fix later
                let vc = ModuleBuilder().createCustomTestModule(vcIndex: vcIndex + 1, testIndex: testIndex) as? CustomTestsViewController
                if vcIndex == 0{
                    vc?.totalScore = presenter.calculateScore(index: indexPath)
                }
                else{
                    let scores = presenter.calculateScore(index: indexPath)
                    for i in 0..<scores.count{
                        self.totalScore[i] = self.totalScore[i] + scores[i]
                    }
                    vc?.totalScore = self.totalScore
                }
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            else{
                performSegue(withIdentifier: "resultsVC", sender: nil)
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewTitle.identifier, for: indexPath) as? CollectionViewTitle{
            sectionHeader.titleLabel.text = ""
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: AnswerViewCell.identifier, for: indexPath) as? AnswerViewCell
        else {fatalError("Invalid Cell kind")}
        presenter.prepareCell(cell: cell, index: indexPath)
        return cell
    }
    
    
}
