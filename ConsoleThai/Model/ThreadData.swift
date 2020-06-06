//
//  Data.swift
//  ConsoleThai
//
//  Created by Surote Gaide on 20/5/20.
//  Copyright © 2020 Surote Gaide. All rights reserved.
//

import Foundation

struct ThreadData: Codable {
    let threads: [Thread]
}

struct Thread: Codable {
    let title: String
    let prefixID: Int
    let username: String
    let isWatching: Bool
    let viewCount: Int
    

    enum CodingKeys: String, CodingKey {
        case title
        case prefixID = "prefix_id"
        case username
        case isWatching = "is_watching"
        case viewCount = "view_count"
    }
}
