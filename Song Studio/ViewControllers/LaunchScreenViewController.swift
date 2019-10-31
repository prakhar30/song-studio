//
//  LaunchScreenViewController.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 01/11/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.timer = Timer(timeInterval: 1.2, target: self, selector: #selector(self.launchNextScreen), userInfo: nil, repeats: false)
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc func launchNextScreen() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.openMainScreen()
    }

}
