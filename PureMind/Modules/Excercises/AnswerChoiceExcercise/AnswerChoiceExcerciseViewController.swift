//
//  AnswerChoiceExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 21.01.2022.
//

import UIKit
import AVFoundation

protocol AnswerChoiceExcerciseViewProtocol: UIViewController{
    func updateUI(audioData: Data?)
    func sendAlert(text: String)
    func updateCollectionView()
}

class AnswerChoiceExcerciseViewController: UIViewController {
    
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backwardsButtonShell: UIButton!
    @IBOutlet weak var playButtonShell: UIButton!
    
    @IBOutlet weak var forwardButtonShell: UIButton!
    @IBOutlet weak var scrollIndicator: UIPageControl!
    @IBOutlet weak var excerciseNameLabel: UILabel!
    @IBOutlet weak var excerciseDescriptionLabel: UITextView!
    @IBOutlet weak var answersCollectionView: UICollectionView!
    
    var presenter: AnswerChoiceExcercisePresenterProtocol!
    var isPlaying = false
    var vcCount: Int?
    var vcIndex: Int?
    var audioPlayer: AVAudioPlayer?
    var titleText: String?
    var excerciseName: String?
    var excerciseDescription: String?
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background4")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScrollIndicator()
        setupCollectionView()
        presenter.loadAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.isHidden = true
        audioPlayer?.pause()
        playButtonShell.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        isPlaying = false
    }
    
    func setupCollectionView(){
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
    }
    
    func setupView(){
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        backButtonShell.tintColor = lightBlueColor
        titleLabel.text = titleText
        titleLabel.textColor = .white
        excerciseNameLabel.text = excerciseName
        excerciseNameLabel.textColor = grayTextColor
        excerciseDescriptionLabel.text = excerciseDescription
        excerciseDescriptionLabel.textColor = grayTextColor
    }
    
    func setupScrollIndicator(){
        scrollIndicator.isUserInteractionEnabled = false
        scrollIndicator.numberOfPages = vcCount!
        scrollIndicator.currentPage = vcIndex!
    }
    
    func setupPlayer(audioData: Data?){
        forwardButtonShell.setImage(UIImage(named: "forwardButton"), for: .normal)
        backwardsButtonShell.tintColor = .white
        forwardButtonShell.tintColor = .white
        backwardsButtonShell.setImage(UIImage(named: "backButton"), for: .normal)
        playButtonShell.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        if audioData != nil{
            do{
                audioPlayer = try AVAudioPlayer(data: audioData!)
            }
            catch{
                alert(text: "Не удалось загрузить аудио")
                playButtonShell.isUserInteractionEnabled = false
                backButtonShell.isUserInteractionEnabled = false
                forwardButtonShell.isUserInteractionEnabled = false
                backwardsButtonShell.isUserInteractionEnabled = false
            }
        }
        else {
            alert(text: "Не удалось загрузить аудио")
            playButtonShell.isUserInteractionEnabled = false
            backButtonShell.isUserInteractionEnabled = false
            forwardButtonShell.isUserInteractionEnabled = false
            backwardsButtonShell.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
            if isPlaying == true{
                audioPlayer?.pause()
                playButtonShell.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
                isPlaying = false
            }
            else{
                audioPlayer?.play()
                playButtonShell.setBackgroundImage(UIImage(named: "pauseButton"), for: .normal)
                isPlaying = true
            }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backwardsButtonPressed(_ sender: Any) {
        var timeBack = audioPlayer!.currentTime
                timeBack -= 15.0 //backward 15 secs
                if (timeBack > 0) {
                    audioPlayer!.currentTime = timeBack
                } else {
                    audioPlayer!.currentTime = 0
                }
    }
    
    @IBAction func forwardButtonPressed(_ sender: Any) {
        var timeForward = audioPlayer!.currentTime
                timeForward += 15.0 // forward 15 secs
                if (timeForward < audioPlayer!.duration) {
                    audioPlayer!.currentTime = timeForward
                } else {
                    audioPlayer!.currentTime = audioPlayer!.duration
                }
    }
    
    func alert(text: String){
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
}
extension AnswerChoiceExcerciseViewController: AnswerChoiceExcerciseViewProtocol{
    func updateUI(audioData: Data?) {
        setupPlayer(audioData: audioData)
    }
    
    func sendAlert(text: String){
        alert(text: text)
        if text != "Успешно!"{
            playButtonShell.isUserInteractionEnabled = false
            backButtonShell.isUserInteractionEnabled = false
            forwardButtonShell.isUserInteractionEnabled = false
            backwardsButtonShell.isUserInteractionEnabled = false
        }
    }
    
    func updateCollectionView() {
        answersCollectionView.reloadData()
    }
}

extension AnswerChoiceExcerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExcerciseAnswerViewCell.identifier, for: indexPath) as? ExcerciseAnswerViewCell
        else {fatalError("Invalid Cell kind")}
        cell.answerNotChosen = !cell.answerNotChosen
        cell.backgroundColor = lightYellowColor
        presenter.manageAnswer(index: indexPath.row)
 */
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
        guard let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: ExcerciseAnswerViewCell.identifier, for: indexPath) as? ExcerciseAnswerViewCell
        else {fatalError("Invalid Cell kind")}
        presenter.prepareCell(cell: cell, index: indexPath.row)
        return cell
    }
    
}
