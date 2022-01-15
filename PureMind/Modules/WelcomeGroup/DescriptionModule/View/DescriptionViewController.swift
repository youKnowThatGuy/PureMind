//
//  DescriptionViewController.swift
//  PureMind
//
//  Created by Клим on 07.07.2021.
//

import UIKit

protocol DescriptionViewProtocol: UIViewController{
    func updateUI()
}

class DescriptionViewController: UIViewController {

    var presenter: DescriptionPresenterProtocol!
    @IBOutlet weak var cardView: UICollectionView!
    
    @IBOutlet weak var skipButtonOutlet: UIButton!
    
    @IBOutlet weak var scrollIndicator: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = blueBackgorundColor
        skipButtonOutlet.setTitleColor(darkGrayTextColor, for: .normal)
        setupCardView()
        setupIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupIndicator(){
        scrollIndicator.pageIndicatorTintColor = UIColor(red: 254, green: 227, blue: 180)
        scrollIndicator.currentPageIndicatorTintColor = lightYellowColor
    }
    
    func setupCardView(){
        cardView.delegate = self
        cardView.dataSource = self
        cardView.backgroundColor = blueBackgorundColor
        cardView.collectionViewLayout = customLayout()
    }
    
    private func customLayout()-> UICollectionViewLayout{
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 12.0, bottom: 0.0, trailing: 12.0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)), subitem: item, count: 1)
        
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16.0, leading: 0.0, bottom: 16.0, trailing: 0.0)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return UICollectionViewCompositionalLayout(section: section)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "registrationSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.prepare(for: segue, sender: sender)
    }
    
}

extension DescriptionViewController: DescriptionViewProtocol{
    func updateUI() {
        cardView.reloadData()
    }
}

extension DescriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        scrollIndicator.numberOfPages = presenter.cardCount()
        return presenter.cardCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cardView.dequeueReusableCell(withReuseIdentifier: CardViewCell.identifier, for: indexPath) as? CardViewCell
        else {fatalError("Invalid Cell kind")}
        
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        scrollIndicator.currentPage = indexPath.row
    }
    
}
