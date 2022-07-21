//
//  MultipleChoiceDiaryViewController.swift
//  PureMind
//
//  Created by Клим on 21.07.2022.
//

import UIKit

protocol MultipleChoiceDiaryViewProtocol: UIViewController{
    func updateUI()
    func loadQuestion(question: String)
}

class MultipleChoiceDiaryViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var answersCollectionView: UICollectionView!
    @IBOutlet weak var saveButtonShell: UIButton!
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background3")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    var presenter: MultipleChoiceDiaryPresenterProtocol!
    var vcIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        checkVCindex()
        prepareViews()
        presenter.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func prepareViews(){
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        titleLabel.textColor = .white
        descLabel.textColor = .white
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        saveButtonShell.layer.cornerRadius = 15
    }
    
    func checkVCindex(){
        if vcIndex > 0{
            //backButtonShell.isHidden = false
        }
    }
    
    func prepareCollectionView(){
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if vcIndex == 2 {
            performSegue(withIdentifier: "diaryThemeSegue", sender: nil)
        }
        else{
            let vc = ModuleBuilder().createMultipleChoiceDiary(vcIndex: (self.vcIndex) + 1) as? MultipleChoiceDiaryViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
    func inputOwnAnswer(index: IndexPath){
        let alert = UIAlertController(title: "Ваш ответ:", message: "", preferredStyle: .alert)
        
        let addlButton = UIAlertAction(title: "Добавить", style: .default){[weak self] (action) in
            let answer = alert.textFields![0].text!
            self?.presenter.manageCustomAnswer(answer: answer, index: index)
        }
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addTextField{(field) in field.placeholder = "..."}
        alert.addAction(addlButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}

extension MultipleChoiceDiaryViewController: MultipleChoiceDiaryViewProtocol{
    func loadQuestion(question: String) {
        self.descLabel.text = question
    }
    
    func updateUI() {
        answersCollectionView.reloadData()
    }
}

extension MultipleChoiceDiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row >= presenter.getNumberOfItems() - 1{
            inputOwnAnswer(index: indexPath)
        }
        else{
            presenter.manageAnswer(index: indexPath)
        }
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
