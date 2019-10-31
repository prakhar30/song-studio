//
//  MusicPlayerViewController.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 01/11/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

class MusicPlayerViewController: UIViewController {
    
    var selectedSongIndex = 0
    var songList = [Song]()
    lazy var playerQueue : AVQueuePlayer = {
        return AVQueuePlayer()
    }()
    var timeObserverToken: Any?

    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentSliderValue: UILabel!
    @IBOutlet weak var maxSliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
        playInitialSelectedSong()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func prevButtonAction(_ sender: Any) {
        selectedSongIndex = selectedSongIndex - 1
        if selectedSongIndex < 0 {
            selectedSongIndex = songList.count - 1
        }
        replacePlayingSongWith(songAtIndex: selectedSongIndex)
    }
    
    @IBAction func pauseButtonAction(_ sender: Any) {
        if self.playerQueue.isPlaying {
            self.playerQueue.pause()
            self.playPauseButton.setTitle("Play", for: .normal)
        } else {
            self.playerQueue.play()
            self.playPauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        selectedSongIndex = selectedSongIndex + 1
        if selectedSongIndex > songList.count - 1 {
            selectedSongIndex = 0
        }
        replacePlayingSongWith(songAtIndex: selectedSongIndex)
    }
    
    func updateUI() {
        navigationTitle.title = songList[selectedSongIndex].name
        coverImage.sd_setImage(with: URL(string: songList[selectedSongIndex].coverImageURL), completed: nil)
    }
    
    func playInitialSelectedSong() {
        if let url = URL(string: songList[selectedSongIndex].url) {
            let playerItem = AVPlayerItem.init(url: url)
            self.playerQueue.insert(playerItem, after: nil)
            self.playerQueue.play()
            setupSliderValues()
        }
    }
    
    func replacePlayingSongWith(songAtIndex: Int) {
        if let url = URL(string: songList[songAtIndex].url) {
            let nextAVPlayerItem = AVPlayerItem.init(url: url)
            self.playerQueue.replaceCurrentItem(with: nextAVPlayerItem)
            setupSliderValues()
            updateUI()
        }
    }
    
    func setupSliderValues() {
        slider.value = 0.0
        currentSliderValue.text = "00:00"
        maxSliderValue.text = "00:00"
        removePeriodicTimeObserver()
        if let currentItem = self.playerQueue.currentItem {
            let duration: CMTime = currentItem.asset.duration
            let seconds: Float64 = CMTimeGetSeconds(duration)
            self.setupTimerLabel(label: maxSliderValue, seconds: Int(seconds))
            slider.maximumValue = Float(seconds)
            slider.isContinuous = true
            slider.addTarget(self, action: #selector(self.playbackSliderValueChanged(_:)), for: .valueChanged)
            
            let timeScale = CMTimeScale(NSEC_PER_SEC)
            let time = CMTime(seconds: 1.0, preferredTimescale: timeScale)

            timeObserverToken = self.playerQueue.addPeriodicTimeObserver(forInterval: time,
                                                                         queue: .main) {
                                                                            [weak self] time in
                                                                            if self?.playerQueue.currentItem?.status == .readyToPlay {
                                                                                if let cmtime = self?.playerQueue.currentTime() {
                                                                                    let time: Float64 = CMTimeGetSeconds(cmtime)
                                                                                    self?.slider.value = Float(time)
                                                                                    self?.setupTimerLabel(label: self!.currentSliderValue, seconds: Int(time))
                                                                                }
                                                                            }
                                                                            
            }
        }
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider: UISlider) {
        let seconds: Int64 = Int64(playbackSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        self.playerQueue.seek(to: targetTime)
        
        if self.playerQueue.rate == 0 {
            self.playerQueue.play()
        }
    }
    
    func setupTimerLabel(label: UILabel, seconds: Int) {
        let mins = seconds / 60
        let seconds = seconds % 60
        label.text = String(format: "%01d:%02d", mins, seconds)
    }
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            self.playerQueue.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        removePeriodicTimeObserver()
    }

}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
