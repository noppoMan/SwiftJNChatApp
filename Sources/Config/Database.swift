//
//  Database.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import Foundation
import SwiftKnex

public struct Database {
    
    public static let `default` = Database()
    
    public var connectionInfo: KnexConfig {
        let env = ProcessInfo.processInfo.environment
        switch Config.default.env {
        case .development:
            return KnexConfig(
                host: env["MYSQL_HOST"] ?? "localhost",
                user: env["MYSQL_USER"] ?? "root",
                password: env["MYSQL_PASSWORD"],
                database: "swiftjn_chat_service_development",
                isShowSQLLog: true
            )
        case .production:
            return KnexConfig(
                host: env["MYSQL_HOST"]!,
                user: env["MYSQL_USER"]!,
                password: env["MYSQL_PASSWORD"]!,
                database: env["MYSQL_DATABASE"]!
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
