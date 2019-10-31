//
//  AVPlayer.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 01/11/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import Foundation
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
