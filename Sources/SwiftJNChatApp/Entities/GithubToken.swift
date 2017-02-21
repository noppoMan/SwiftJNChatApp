//
//  GithubToken.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import Foundation

enum GithubAPIError: Error {
    case couldNotGetAccessToken
    case invalidCode
}

struct GithubToken {
    let accessToken: String
    let scope: String
    let type: String
}

extension GithubToken: Entity {
    init(row: Row) throws {
        guard let accessToken = row["access_token"] as? String, let scope = row["scope"] as? String, let type = row["token_type"] as? String else {
            throw GithubAPIError.couldNotGetAccessToken
        }
        
        self.init(
            accessToken: accessToken,
            scope: scope,
            type: type
        )
    }
}
