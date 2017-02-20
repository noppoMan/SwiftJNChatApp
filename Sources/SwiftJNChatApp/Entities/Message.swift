//
//  Message.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/20.
//
//

import Foundation
import SwiftProtobuf

extension Message: Entity {
    public init(row: Row) throws {
        guard let id = row["id"] as? Int,
            let text = row["text"] as? String,
            let createdAt = row["created_at"] as? Date,
            let uid = row["u_id"] as? Int,
            let uname = row["u_name"] as? String,
            let ulogin = row["u_login"] as? String,
            let uavaterURL = row["u_avater_url"] as? String
        else {
            throw ValidationError.required("messages.*")
        }
        
        let user = User(id: Int32(uid), login: ulogin, name: uname, avaterURL: uavaterURL)
        
        let ts = Google_Protobuf_Timestamp(secondsSinceEpoch: Int64(createdAt.timeIntervalSince1970))
        
        self.init(id: Int32(id), user: user, text: text, createdAt: ts)
    }
}

extension Message: Serializable {
    public func serialize() throws -> [String: Any] {
        let now = Date().dateTimeString()
        return [
            "text": text,
            "user_id": user.id,
            "created_at": now,
            "updated_at": now
        ]
    }
}
