//
//  SongStruct.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 31/10/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import Foundation

struct Song: Codable {
    var name: String = ""
    var url: String = ""
    var artists: String = ""
    var coverImageURL: String = ""
}
