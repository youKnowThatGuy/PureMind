//
//  TextPictureExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import UIKit
import AVFoundation

class TextPictureExcerciseViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backwardsButtonShell: UIButton!
    @IBOutlet weak var playButtonShell: UIButton!
    @IBOutlet weak var topView: UIView!
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
    var imageId = ""
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background12")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        setupView()
        presenter.loadAudio()
        setupScrollIndicator()
        setupImage()
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //imageView.isHidden = true
        audioPlayer?.pause()
        playButtonShell.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        isPlaying = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //imageView.isHidden = false
    }
    
    func setupView(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        topView.backgroundColor = UIColor(patternImage: UIImage(named: "background14")!)
        topView.layer.cornerRadius = 20
        titleLabel.text = titleText
        titleLabel.textColor = newButtonLabelColor
        excerciseNameLabel.text = excerciseName
        excerciseNameLabel.textColor = newButtonLabelColor
        excerciseDescriptionLabel.text = excerciseDescription
        excerciseDescriptionLabel.textColor = newButtonLabelColor
        saveButtonShell.setTitleColor(newButtonLabelColor, for: .normal)
        saveButtonShell.layer.borderColor = newButtonLabelColor.cgColor
        saveButtonShell.layer.cornerRadius = 20
        noteTextView.backgroundColor = .white
        noteTextView.layer.borderWidth = 2
        noteTextView.layer.borderColor = newButtonLabelColor.cgColor
        noteTextView.layer.cornerRadius = 20
    }
    
    func setupImage(){
        if imageId == "" {
            excerciseImage.image = UIImage(named: "noImage")
        }
        else{
            NetworkService.shared.loadImage(from: imageId) {[weak self] (result) in
                guard let image = result
                else {self?.excerciseImage.image = UIImage(named: "noImage")
                    return
                }
                self?.excerciseImage.image = image
            }
        }
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
                forwardButtonShell.isUserInteractionEnabled = false
                backwardsButtonShell.isUserInteractionEnabled = false
            }
        }
        else {
            alert(title: "Ошибка", text: "Не удалось загрузить аудио")
            playButtonShell.isUserInteractionEnabled = false
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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if noteTextView.hasText{
            presenter.sendText(userText: noteTextView.text)
        }
    }
    
    func alert(title: String,text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
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
        alert(title: "Спасибо!", text: text)
        if text != "Успешно!"{
            playButtonShell.isUserInteractionEnabled = false
            forwardButtonShell.isUserInteractionEnabled = false
            backwardsButtonShell.isUserInteractionEnabled = false
        }
    }
}
