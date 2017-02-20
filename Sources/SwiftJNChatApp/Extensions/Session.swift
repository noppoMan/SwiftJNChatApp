//
//  Session.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/19.
//
//

import Foundation
import APIKit

extension Session {
    static func sendSync<Request: APIKit.Request>(_ request: Request) throws -> Request.Response {
        let wg = WaitGroup()
        wg.add(1)
        
        var result: Request.Response?
        var error: Error?
        
        Session.send(request) {
            switch $0 {
            case .success(let r):
                result = r
                
            case .failure(let e):
                error = e
            }
            wg.done()
        }
        wg.wait()
        
        if let err = error {
            throw err
        }
        
        return result!
    }
}
