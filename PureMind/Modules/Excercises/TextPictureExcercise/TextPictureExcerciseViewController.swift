//
//  TextPictureExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import UIKit
import AVFoundation

class TextPictureExcerciseViewController: UIViewController {
    
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backwardsButtonShell: UIButton!
    @IBOutlet weak var playButtonShell: UIButton!
    
    @IBOutlet weak var forwardButtonShell: UIButton!
    @IBOutlet weak var scrollIndicator: UIPageControl!
    @IBOutlet weak var excerciseNameLabel: UILabel!
    @IBOutlet weak var excerciseDescriptionLabel: UITextView!
    @IBOutlet weak var saveButtonShell: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var excerciseImage: UIImageView!
    
    var presenter: TextExcercisePresenterProtocol!
    var isPlaying = false
    var vcCount: Int?
    var vcIndex: Int?
    var audioPlayer: AVAudioPlayer?
    var titleText: String?
    var excerciseName: String?
    var excerciseDescription: String?
    var image: UIImage?
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background3")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.loadAudio()
        setupScrollIndicator()
    }
    
    func setupView(){
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        titleLabel.text = titleText
        excerciseNameLabel.text = excerciseName
        excerciseDescriptionLabel.text = excerciseDescription
        excerciseImage.image = image
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        saveButtonShell.layer.cornerRadius = 15
        noteTextView.backgroundColor = .white
        noteTextView.layer.borderWidth = 2
        noteTextView.layer.borderColor = lightYellowColor.cgColor
        noteTextView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background3")!)
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
                playButtonShell.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if noteTextView.hasText{
            presenter.sendText(userText: noteTextView.text)
        }
    }
    
    func alert(text: String){
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить аудио", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
}
extension TextPictureExcerciseViewController: TextExcerciseViewProtocol{
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
}
