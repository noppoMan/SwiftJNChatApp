//
//  User.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import Foundation


extension User: Entity, Serializable {
    
    public init(row: Row) throws {
        
        guard let id = row["id"] as? Int else {
            throw ValidationError.required("users.id")
        }
        
        guard let login = row["login"] as? String else {
            throw ValidationError.required("users.login")
        }
        
        guard let avaterURL = row["avatar_url"] as? String else {
            throw ValidationError.required("users.avatar_url")
        }
        
        self.init()
        self.id = Int32(id)
        self.login = login
        self.name = row["name"] as? String ?? login
        self.avaterURL = avaterURL
    }
    
    public func serialize() throws -> [String : Any] {
        let now = Date().dateTimeString()
        return [
            "login": login,
            "name": name,
            "avatar_url": avaterURL,
            "created_at": now,
            "updated_at": now
        ]
    }
    
}
