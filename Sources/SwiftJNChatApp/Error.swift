//
//  Error.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

enum ValidationError: Error {
    case required(String)
}


enum DBError: Error {
    case insertFailed
}
