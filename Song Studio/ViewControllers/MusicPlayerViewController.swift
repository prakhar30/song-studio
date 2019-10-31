//
//  MusicPlayerViewController.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 01/11/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import UIKit
import SDWebImage

class MusicPlayerViewController: UIViewController {
    
    var selectedSongIndex = 0
    var songList = [Song]()

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
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func prevButtonAction(_ sender: Any) {
    }
    
    @IBAction func pauseButtonAction(_ sender: Any) {
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
    }
}
