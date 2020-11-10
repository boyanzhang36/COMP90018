//
//  Channel.swift
//  Messager
//
//  Created by 陆敏慎 on 31/10/20.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Channel: Codable {
    
    var id = ""
    var name = ""
    var adminId = ""
    var memberIds = [""]
    var avatarLink = ""
    var aboutChannel = ""
    @ServerTimestamp var createdDate = Date()
    @ServerTimestamp var lastMessageDate = Date()

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case adminId
        case memberIds
        case avatarLink
        case aboutChannel
        case createdDate
        case lastMessageDate = "date"
    }
}

