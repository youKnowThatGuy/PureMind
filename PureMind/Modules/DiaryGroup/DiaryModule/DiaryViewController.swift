//
//  DiaryViewController.swift
//  PureMind
//
//  Created by Клим on 11.07.2022.
//

import UIKit

protocol DiaryViewProtocol: UIViewController{
    func updateUI()
}

class DiaryViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notesCollectionView: UICollectionView!
    @IBOutlet weak var fadingLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addButtonShell: UIButton!
    var presenter: DiaryPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getData()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getData()
        tabBarItem.isEnabled = true
    }
        
    func setupView(){
        topView.backgroundColor = UIColor(red: 248, green: 232, blue: 187)
        topView.layer.cornerRadius = 20
        fadingLabel.textColor = grayTextColor
        titleLabel.textColor = newButtonLabelColor
        addButtonShell.layer.cornerRadius = 10
        addButtonShell.backgroundColor = newButtonLabelColor
        notesCollectionView.delegate = self
        notesCollectionView.dataSource = self
        self.tabBarItem.isEnabled = false
        if presenter.notesCount() > 0 {
            fadingLabel.isHidden = true
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "showMultipleDiarySegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
}

extension DiaryViewController: DiaryViewProtocol{
    func updateUI() {
        notesCollectionView.reloadData()
    }
}

extension DiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.notesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = notesCollectionView.dequeueReusableCell(withReuseIdentifier: DiaryNoteCollectionViewCell.identifier, for: indexPath) as? DiaryNoteCollectionViewCell
        else {fatalError("Invalid Cell kind")}
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell
    }
}
