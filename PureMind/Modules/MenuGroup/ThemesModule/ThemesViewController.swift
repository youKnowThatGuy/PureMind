//
//  ThemesViewController.swift
//  PureMind
//
//  Created by Клим on 30.07.2021.
//

import UIKit

protocol ThemesViewProtocol: UIViewController{
    func updateUI()
}

class ThemesViewController: UIViewController {
    var presenter: ThemesPresenterProtocol!

    @IBOutlet weak var themesCollectionView: UICollectionView!
    @IBOutlet weak var continueButtonShell: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
    }
    
    func prepareCollectionView(){
        themesCollectionView.delegate = self
        themesCollectionView.dataSource = self
        
    }
    
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "therapistChoiceSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    

}

extension ThemesViewController: ThemesViewProtocol{
    func updateUI() {
        themesCollectionView.reloadData()
        if presenter.selectedThemesCount() > 0{
            continueButtonShell.setTitle("Подтвердить", for: .normal)
        }
        else{
            continueButtonShell.setTitle("Пропустить", for: .normal)
        }
    }
}

extension ThemesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = themesCollectionView.dequeueReusableCell(withReuseIdentifier: ThemeViewCell.identifier, for: indexPath) as? ThemeViewCell
        else {fatalError("Invalid Cell kind")}
        cell.themeNotChosen = !cell.themeNotChosen
        cell.checkBoxLabel.isHidden = false
        presenter.manageTheme(index: indexPath.row)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.themesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = themesCollectionView.dequeueReusableCell(withReuseIdentifier: ThemeViewCell.identifier, for: indexPath) as? ThemeViewCell
        else {fatalError("Invalid Cell kind")}
        
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell
    }
    
}
