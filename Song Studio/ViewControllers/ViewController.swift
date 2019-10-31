//
//  ViewController.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 31/10/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func fetchSongsList() {
        if ReachabilityManager.shared.isConnectedToNetwork() {
            APIManager.shared.getSongsList(success: { (result) in
            }, failure: { (failureString) in
                print("Failure \(failureString)")
            })
        } else {
            // SHOW INTERNET NOT CONNECTED POPUP
        }
    }
}

