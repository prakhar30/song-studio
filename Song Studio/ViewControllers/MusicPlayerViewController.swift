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
    
    var selectedSongIndex = 0 {
        didSet {
            print(selectedSongIndex)
        }
    }
    var songList = [Song]()
    lazy var playerQueue : AVQueuePlayer = {
        return AVQueuePlayer()
    }()

    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle.title = songList[selectedSongIndex].name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coverImage.sd_setImage(with: URL(string: songList[selectedSongIndex].coverImageURL), completed: nil)
        playCurrentSong(atIndex: selectedSongIndex)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func prevButtonAction(_ sender: Any) {
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
    }
    
    func playCurrentSong(atIndex: Int) {
        if let url = URL(string: songList[atIndex].url) {
            let playerItem = AVPlayerItem.init(url: url)
            self.playerQueue.insert(playerItem, after: nil)
            self.playerQueue.play()
        }
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
