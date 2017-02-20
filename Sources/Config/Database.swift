//
//  Database.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import SwiftKnex

public struct Database {
    
    public static let `default` = Database()
    
    public var connectionInfo: KnexConfig {
        switch Config.default.env {
        case .development:
            return KnexConfig(
                host: "localhost",
                user: "root",
                database: "swiftjn_chat_service_development"
            )
        default:
            return KnexConfig(
                host: "TBD",
                user: "TBD",
                database: "TBD"
            )
        }
    }
}