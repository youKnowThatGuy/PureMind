//
//  TextExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 12.10.2021.
//

import UIKit
import AVFoundation

protocol TextExcerciseViewProtocol: UIViewController{
    func updateUI(audioData: Data?)
    func sendAlert(text: String)
}


class TextExcerciseViewController: UIViewController {
    
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
    var presenter: TextExcercisePresenterProtocol!
    var isPlaying = false
    var vcCount: Int?
    var vcIndex: Int?
    var audioPlayer: AVAudioPlayer?
    var titleText: String?
    var excerciseName: String?
    var excerciseDescription: String?
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "background3")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseDescriptionLabel.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        setupView()
        setupScrollIndicator()
        presenter.loadAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.isHidden = false
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.isHidden = true
        audioPlayer?.pause()
        playButtonShell.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        isPlaying = false
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
        titleLabel.text = titleText
        titleLabel.textColor = titleYellow
        backButtonShell.tintColor = titleYellow
        excerciseNameLabel.text = excerciseName
        excerciseNameLabel.textColor = grayTextColor
        excerciseDescriptionLabel.text = excerciseDescription
        excerciseDescriptionLabel.textColor = grayTextColor
        saveButtonShell.setTitleColor(.white, for: .normal)
        saveButtonShell.layer.backgroundColor = lightYellowColor.cgColor
        saveButtonShell.layer.cornerRadius = 15
        noteTextView.backgroundColor = .white
        noteTextView.layer.borderWidth = 2
        noteTextView.layer.borderColor = lightYellowColor.cgColor
        noteTextView.layer.cornerRadius = 10
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
       let size = image.size
       
       let widthRatio  = targetSize.width  / size.width
       let heightRatio = targetSize.height / size.height
       
       // Figure out what our orientation is, and use that to form the rectangle
       var newSize: CGSize
       if(widthRatio > heightRatio) {
           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
       } else {
           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
       }
       
       // This is the rect that we've calculated out and this is what is actually used below
       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
       
       // Actually do the resizing to the rect using the ImageContext stuff
       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
       image.draw(in: rect)
       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       
       return newImage!
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
                playButtonShell.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
                isPlaying = true
            }
        
    }
    
    func alert(title: String,text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
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
            if timeForward < audioPlayer!.duration {
                audioPlayer!.currentTime = timeForward
            }
            else {
                audioPlayer!.currentTime = audioPlayer!.duration
            }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if noteTextView.hasText{
            presenter.sendText(userText: noteTextView.text)
        }
    }
    
    
}
extension TextExcerciseViewController: TextExcerciseViewProtocol{
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
