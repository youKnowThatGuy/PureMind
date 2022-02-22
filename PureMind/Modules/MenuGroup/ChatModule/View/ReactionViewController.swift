//
//  ReactionViewController.swift
//  PureMind
//
//  Created by Клим on 06.11.2021.
//

import UIKit

class ReactionViewController: UIViewController {
    @IBOutlet weak var backingImageView: UIImageView!
    @IBOutlet weak var dimmerView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    
    var backingImage: UIImage?
    var multipleChoice: Bool?
    var buttons = [String]()
    var parentPresenter: ChatPresenter!
    @IBOutlet weak var buttonsCollectionView: UICollectionView!
    
    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backingImageView.image = backingImage
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 10.0
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        dimmerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:))))
        dimmerView.isUserInteractionEnabled = true
        
        // hide the card view at the bottom when the View first load
        if let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
        let bottomPadding = keyWindow?.safeAreaInsets.bottom {
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        }
        dimmerView.alpha = 0.0
        setupButtonsCollectionView()
    }
    
    func setupButtonsCollectionView(){
        buttonsCollectionView.delegate = self
        buttonsCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCard()
    }
    
    @IBAction func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideCardAndGoBack()
    }

    //MARK: Animations
    private func showCard() {
         // ensure there's no pending layout changes before animation runs
         self.view.layoutIfNeeded()
         // set the new top constraint value for card view
         // card view won't move up just yet, we need to call layoutIfNeeded()
         // to tell the app to refresh the frame/position of card view
        if let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
           let bottomPadding = keyWindow?.safeAreaInsets.bottom {
           // when card state is normal, its top distance to safe area is
           // (safe area height + bottom inset) / 2.0
           cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding) / 1.5
         }
         // move card up from bottom by telling the app to refresh the frame/position of view
         // create a new property animator
         let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
           self.view.layoutIfNeeded()
         })
         
         // show dimmer view
         // this will animate the dimmerView alpha together with the card move up animation
         showCard.addAnimations({
           self.dimmerView.alpha = 0.7
         })
         
         // run the animation
         showCard.startAnimation()
    }
    
    private func hideCardAndGoBack() {
        // ensure there's no pending layout changes before animation runs
          self.view.layoutIfNeeded()
          
          // set the new top constraint value for card view
          // card view won't move down just yet, we need to call layoutIfNeeded()
          // to tell the app to refresh the frame/position of card view
        if let safeAreaHeight = keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height,
        let bottomPadding = keyWindow?.safeAreaInsets.bottom {
            // move the card view to bottom of screen
            cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
          }
          // move card down to bottom
          // create a new property animator
          let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
          })
          // hide dimmer view
          // this will animate the dimmerView alpha together with the card move down animation
          hideCard.addAnimations {
            self.dimmerView.alpha = 0.0
          }
          // when the animation completes, (position == .end means the animation has ended)
          // dismiss this view controller (if there is a presenting view controller)
          hideCard.addCompletion({ position in
            if position == .end {
                self.navigationController?.popViewController(animated: false)
            }
          })
          // run the animation
          hideCard.startAnimation()
    }
    
    func prepareCell(prepare cell: ButtonCollectionViewCell, for index: Int){
        let buttonText = buttons[index]
        let check = parentPresenter.selectedMultipleAnswers.firstIndex(of: buttonText)
        if check == nil{
            cell.unselectedView()
        }
        else{
            cell.selectedView()
        }
        cell.label.text = buttonText
    }
}

extension ReactionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as? ButtonCollectionViewCell else { fatalError("Invalid cell kind") }
        prepareCell(prepare: cell, for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if multipleChoice == true && indexPath.row < 6{
            parentPresenter.manageMultipleAnswers(index: indexPath.row)
            hideCardAndGoBack()
        }
        else{
            parentPresenter.getResponse(for: indexPath.row)
            hideCardAndGoBack()
        }
    }
    
}
