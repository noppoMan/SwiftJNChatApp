//
//  GithubAPIError.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

enum GithubAPIError: Error {
    case invalidCode
    case couldNotGetAccessToken
    case unsatisfiedBody(String)
}
