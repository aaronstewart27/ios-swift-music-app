//
//  PlayerViewController.swift
//  MyMusicApp
//
//  Created by Aaron Stewart on 4/21/16.
//  Copyright © 2016 Aaron Stewart. All rights reserved.
//

//import Cocoa
import UIKit
import AVFoundation


class PlayerViewController: UIViewController {
    
    var songTitle:String = ""
    var artist:String = ""
    var streamURL:String = ""
    var artURL:String = ""
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var songLabelTitle: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var artwork: UIImageView!
    
    @IBOutlet weak var myVolumeController: UISlider!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
//    @IBOutlet weak var stopButton: UIButton!
    
//    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func playButtonPressed(sender: AnyObject) {
        self.audioPlayer.play()
        self.playButton.hidden = true
        self.pauseButton.hidden = false
    }
    
    @IBAction func pauseButtonPressed(sender: AnyObject) {
        self.audioPlayer.pause()
        self.playButton.hidden = false
        self.pauseButton.hidden = true
    }
    
    @IBAction func controlVolume(sender: AnyObject) {
        self.audioPlayer.volume = myVolumeController.value
        
    }
    
//    @IBAction func stopButtonPressed(sender: AnyObject) {
//        self.audioPlayer.pause()
//        
//        
//    }
    
//    @IBAction func restartButtonPressed(sender: AnyObject) {
//        
//        self.audioPlayer.pause()
//        
//    }
    
    var audioPlayer = AVPlayer()
    
    override func viewDidLoad(){
        
        if let artworkURL = NSURL(string: artURL) {
            if let data = NSData(contentsOfURL: artworkURL) {
                if let imageURL = UIImage(data: data) {
                    self.artwork.image = imageURL
                }
            }
        }
        
        songLabelTitle.text = songTitle
        artistLabel.text = artist
        
        do {
            let url = streamURL + "?client_id=5f61421beef03933a192f6ea1266e293"
            let fileURL = NSURL(string:url)
            self.audioPlayer = try AVPlayer(URL: fileURL!)
            audioPlayer.volume = 1.0
            audioPlayer.play()
            self.playButton.hidden = true
            self.pauseButton.hidden = false
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateAudioProgressView", userInfo: nil, repeats: true)
        } catch {
            print("Error getting the audio file")
        }
        
        
        
    }
    
    
    func updateAudioProgressView() {
        if (audioPlayer.rate != 0 && audioPlayer.error == nil) {
            progressBar.setProgress(calcProgress(), animated: false)
        }
    }
    
    func calcProgress() -> Float {
        let audioPlayerDuration = CMTimeGetSeconds(self.audioPlayer.currentItem!.asset.duration)
        return Float(CMTimeGetSeconds(self.audioPlayer.currentTime()) / audioPlayerDuration)
    }
    
    override func viewWillDisappear(animated: Bool) {
        audioPlayer.pause()
    }
    
    
}
