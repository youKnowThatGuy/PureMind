//
//  YesNoExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import UIKit
import AVKit

class YesNoExcerciseViewController: UIViewController {
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backwardsButtonShell: UIButton!
    @IBOutlet weak var playButtonShell: UIButton!
    
    @IBOutlet weak var forwardButtonShell: UIButton!
    @IBOutlet weak var scrollIndicator: UIPageControl!
    @IBOutlet weak var excerciseNameLabel: UILabel!
    @IBOutlet weak var excerciseDescriptionLabel: UILabel!
    @IBOutlet weak var yesButtonShell: UIButton!
    @IBOutlet weak var noButtonShell: UIButton!
    var presenter: TextExcercisePresenterProtocol!
    var isPlaying = false
    var vcCount: Int?
    var vcIndex: Int?
    var audioPlayer: AVAudioPlayer?
    var titleText: String?
    var excerciseName: String?
    var excerciseDescription: String?
    
    var finishVC = false
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
        presenter.loadAudio()
        setupScrollIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.isHidden = false
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
        excerciseNameLabel.textColor = grayTextColor
        excerciseNameLabel.text = excerciseName
        excerciseDescriptionLabel.text = excerciseDescription
        excerciseDescriptionLabel.textColor = grayTextColor
        yesButtonShell.setBackgroundImage(UIImage(named: "excButton"), for: .normal)
        noButtonShell.setBackgroundImage(UIImage(named: "excButton"), for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.isHidden = true
        audioPlayer?.pause()
        playButtonShell.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        isPlaying = false
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
                alert(title: "Ошибка", text: "Не удалось загрузить аудио")
                playButtonShell.isUserInteractionEnabled = false
                backButtonShell.isUserInteractionEnabled = false
                forwardButtonShell.isUserInteractionEnabled = false
                backwardsButtonShell.isUserInteractionEnabled = false
            }
        }
        else {
            alert(title: "Ошибка", text: "Не удалось загрузить аудио")
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
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        if finishVC == true {
            navigationController?.popViewController(animated: true)
        }
        yesButtonShell.setBackgroundImage(UIImage(named: "excButton_highlited"), for: .normal)
        noButtonShell.setBackgroundImage(UIImage(named: "excButton"), for: .normal)
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
        if finishVC == true {
            navigationController?.popViewController(animated: true)
        }
        yesButtonShell.setBackgroundImage(UIImage(named: "excButton"), for: .normal)
        noButtonShell.setBackgroundImage(UIImage(named: "excButton_highlited"), for: .normal)
    }
    
    func alert(title: String,text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }

}

extension YesNoExcerciseViewController: TextExcerciseViewProtocol{
    func updateUI(audioData: Data?) {
        setupPlayer(audioData: audioData)
    }
    
    func sendAlert(text: String){
        alert(title: "Спасибо!", text: text)
        if text != "Успешно!"{
            playButtonShell.isUserInteractionEnabled = false
            backButtonShell.isUserInteractionEnabled = false
            forwardButtonShell.isUserInteractionEnabled = false
            backwardsButtonShell.isUserInteractionEnabled = false
        }
    }
}
