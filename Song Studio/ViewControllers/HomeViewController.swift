//
//  ViewController.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 31/10/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var songList = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.tableFooterView = UIView()
        self.fetchSongsList()
    }
    
    func fetchSongsList() {
        if ReachabilityManager.shared.isConnectedToNetwork() {
            APIManager.shared.getSongsList(success: { (result) in
                self.processResults(result: result)
            }, failure: { (failureString) in
                print("Failure \(failureString)")
            })
        } else {
            // SHOW INTERNET NOT CONNECTED POPUP
        }
    }
    
    func processResults(result: JSON) {
        for song in result {
            let songJSON = song.1
            let song = Song(name: songJSON["song"].stringValue, url: songJSON["url"].stringValue, artists: songJSON["artists"].stringValue, coverImageURL: songJSON["cover_image"].stringValue)
            self.songList.append(song)
        }
        self.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let musicPlayerVC = storyboard.instantiateViewController(withIdentifier: "MusicPlayerViewController_ID") as! MusicPlayerViewController
        musicPlayerVC.selectedSongIndex = indexPath.row
        musicPlayerVC.songList = self.songList
        navigationController?.pushViewController(musicPlayerVC, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SongListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as! SongListTableViewCell
        cell.songName.text = self.songList[indexPath.row].name
        cell.songArtists.text = self.songList[indexPath.row].artists
        return cell
    }
    
    
}
