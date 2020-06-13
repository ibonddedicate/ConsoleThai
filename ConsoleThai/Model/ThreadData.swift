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
    let userID: Int
    let viewCount: Int
    let firstPostID: Int

    enum CodingKeys: String, CodingKey {
        case title
        case prefixID = "prefix_id"
        case username
        case userID = "user_id"
        case viewCount = "view_count"
        case firstPostID = "first_post_id"
    }
}


struct PostData: Codable {
    let post : PostInfo
}
struct PostInfo: Codable {
    let attachments: [Attachments]?
    let message : String
    let postDate : Int
    let thread : ThreadInPost
    
    enum CodingKeys: String, CodingKey {
        case attachments = "Attachments"
        case message
        case postDate = "post_date"
        case thread = "Thread"
    }
}

struct ThreadInPost : Codable {
    let customfields : CustomField
    
    enum CodingKeys: String, CodingKey {
        case customfields = "custom_fields"
    }
}

struct CustomField: Codable {
    let contactField: String
    let conditionField: String
    
    enum CodingKeys: String, CodingKey {
        case contactField = "contact_field_thread"
        case conditionField = "condition_field"
    }
}

struct Attachments: Codable {
    let attachmentID:Int
    let thumbnailUrl:String
    
    enum CodingKeys: String, CodingKey {
        case attachmentID = "attachment_id"
        case thumbnailUrl = "thumbnail_url"
    }
}
