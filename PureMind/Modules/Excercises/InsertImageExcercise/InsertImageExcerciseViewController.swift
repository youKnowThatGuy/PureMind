//
//  InsertImageExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import UIKit
import AVKit

protocol InsertImageExcerciseViewProtocol: UIViewController{
    func updateUI(audioData: Data?)
    func failedToLoad()
}

class InsertImageExcerciseViewController: UIViewController {
    
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backwardsButtonShell: UIButton!
    @IBOutlet weak var playButtonShell: UIButton!
    
    @IBOutlet weak var forwardButtonShell: UIButton!
    @IBOutlet weak var scrollIndicator: UIPageControl!
    @IBOutlet weak var excerciseNameLabel: UILabel!
    @IBOutlet weak var excerciseDescriptionLabel: UITextView!
    @IBOutlet weak var insertButtonShell: UIButton!
    @IBOutlet weak var insertedImageView: UIImageView!
    
    var presenter: InsertImageExcercisePresenterProtocol!
    var isPlaying = false
    var vcCount: Int?
    var vcIndex: Int?
    var audioPlayer: AVAudioPlayer?
    var titleText: String?
    var excerciseName: String?
    var excerciseDescription: String?
    
    @IBOutlet weak var uploadImg: UIImageView!
    var insertedImage: UIImage?
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
        setupScrollIndicator()
        presenter.loadAudio()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.isHidden = true
        audioPlayer?.pause()
        playButtonShell.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        isPlaying = false
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
        insertButtonShell.setTitleColor(lightYellowColor, for: .normal)
        insertButtonShell.layer.borderColor = lightYellowColor.cgColor
        insertButtonShell.layer.borderWidth = 2
        insertButtonShell.layer.cornerRadius = 15
        backButtonShell.tintColor = lightYellowColor
        titleLabel.textColor = titleYellow
        backButtonShell.tintColor = titleYellow
        excerciseNameLabel.textColor = grayTextColor
        titleLabel.text = titleText
        excerciseNameLabel.text = excerciseName
        excerciseDescriptionLabel.text = excerciseDescription
    }
    
    func setupScrollIndicator(){
        scrollIndicator.isUserInteractionEnabled = false
        scrollIndicator.numberOfPages = vcCount!
        scrollIndicator.currentPage = vcIndex!
    }
    
    func updateImageView(){
        insertedImageView.image = insertedImage
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
                alert()
                playButtonShell.isUserInteractionEnabled = false
                backButtonShell.isUserInteractionEnabled = false
                forwardButtonShell.isUserInteractionEnabled = false
                backwardsButtonShell.isUserInteractionEnabled = false
            }
        }
        else {
            alert()
            playButtonShell.isUserInteractionEnabled = false
            backButtonShell.isUserInteractionEnabled = false
            forwardButtonShell.isUserInteractionEnabled = false
            backwardsButtonShell.isUserInteractionEnabled = false
        }
    }
    
    func alert(){
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить аудио", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Oк", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
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
    
    @IBAction func insertButtonPressed(_ sender: Any) {
        showImagePickerController()
    }
}

extension InsertImageExcerciseViewController: InsertImageExcerciseViewProtocol{
    func updateUI(audioData: Data?) {
        setupPlayer(audioData: audioData)
    }
    
    func failedToLoad(){
        alert()
        playButtonShell.isUserInteractionEnabled = false
        backButtonShell.isUserInteractionEnabled = false
        forwardButtonShell.isUserInteractionEnabled = false
        backwardsButtonShell.isUserInteractionEnabled = false
    }
}

extension InsertImageExcerciseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func showImagePickerController(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true){[weak self] in
            self?.insertButtonShell.backgroundColor = lightYellowColor
            self?.insertButtonShell.setTitleColor(.white, for: .normal)
            self?.insertButtonShell.setTitle("Продолжить", for: .normal)
            self?.uploadImg.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            insertedImage = editedImage
            updateImageView()
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            insertedImage = originalImage
            updateImageView()
        }
        
        dismiss(animated: true, completion: nil)
    }
}
