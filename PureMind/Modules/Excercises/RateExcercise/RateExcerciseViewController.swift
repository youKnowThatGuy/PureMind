//
//  RateExcerciseViewController.swift
//  PureMind
//
//  Created by Клим on 13.10.2021.
//

import UIKit
import AVFoundation

class RateExcerciseViewController: UIViewController {
    @IBOutlet weak var backButtonShell: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backwardsButtonShell: UIButton!
    @IBOutlet weak var playButtonShell: UIButton!
    
    @IBOutlet weak var forwardButtonShell: UIButton!
    @IBOutlet weak var scrollIndicator: UIPageControl!
    @IBOutlet weak var excerciseFinishedLabel: UILabel!
    @IBOutlet weak var rateExcerciseLabel: UILabel!
    @IBOutlet weak var finishingPicture: UIImageView!
    @IBOutlet weak var starButton1Shell: UIButton!
    @IBOutlet weak var starButton2Shell: UIButton!
    @IBOutlet weak var starButton3Shell: UIButton!
    @IBOutlet weak var starButton4Shell: UIButton!
    @IBOutlet weak var starButton5Shell: UIButton!
    var url: URL?
    var isPlaying = false
    var vcCount: Int?
    var vcIndex: Int?
    var titleText: String?
    var numberOfStarsHighlighted = 0
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollIndicator()
        setupView()
        setupPlayer()
    }
    
    func setupView(){
        titleLabel.text = titleText
    }
    
    func setupScrollIndicator(){
        scrollIndicator.isUserInteractionEnabled = false
        scrollIndicator.numberOfPages = vcCount!
        scrollIndicator.currentPage = vcIndex!
    }
    
    func setupPlayer(){
        playButtonShell.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
        }
        catch{
            fatalError("No audio found")
        }
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if isPlaying == true{
            audioPlayer?.pause()
            playButtonShell.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
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
    
    @IBAction func starButton1Pressed(_ sender: Any) {
        let starShells = [starButton1Shell, starButton2Shell, starButton3Shell, starButton4Shell, starButton5Shell]
        if numberOfStarsHighlighted < 1{
            starButton1Shell.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            numberOfStarsHighlighted = 1
        }
        else{
            for star in starShells{
                star?.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                numberOfStarsHighlighted = 0
            }
        }
        
    }
    
    @IBAction func starButton2Pressed(_ sender: Any) {
        let starShells = [starButton1Shell, starButton2Shell, starButton3Shell, starButton4Shell, starButton5Shell]
        if numberOfStarsHighlighted < 2{
            starButton1Shell.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            starButton2Shell.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            numberOfStarsHighlighted = 2
        }
        else{
            for i in 1..<starShells.count{
                starShells[i]!.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                numberOfStarsHighlighted = 1
            }
        }
    }
    
    @IBAction func starButton3Pressed(_ sender: Any) {
        let starShells = [starButton1Shell, starButton2Shell, starButton3Shell, starButton4Shell, starButton5Shell]
        if numberOfStarsHighlighted < 3{
            for i in 0..<3{
                starShells[i]!.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            numberOfStarsHighlighted = 3
        }
        else{
            for i in 2..<starShells.count{
                starShells[i]!.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                numberOfStarsHighlighted = 2
            }
        }
    }
    
    @IBAction func starButton4Pressed(_ sender: Any) {
        let starShells = [starButton1Shell, starButton2Shell, starButton3Shell, starButton4Shell, starButton5Shell]
        if numberOfStarsHighlighted < 4{
            for i in 0..<4{
                starShells[i]!.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            numberOfStarsHighlighted = 4
        }
        else{
            for i in 3..<starShells.count{
                starShells[i]!.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                numberOfStarsHighlighted = 3
            }
        }
    }
    
    @IBAction func starButton5Pressed(_ sender: Any) {
        let starShells = [starButton1Shell, starButton2Shell, starButton3Shell, starButton4Shell, starButton5Shell]
        if numberOfStarsHighlighted < 5{
            for i in 0..<starShells.count{
                starShells[i]!.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            numberOfStarsHighlighted = 5
        }
        else{
            for i in 4..<starShells.count{
                starShells[i]!.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                numberOfStarsHighlighted = 4
            }
        }
    }
    
}
