//
//  JSONParser.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/20.
//
//

import Foundation
import WebAppKit

struct JSONParserMiddleware: Middleware {
    
    public func respond(to request: Request, response: Response) throws -> Chainer {
        guard let contentType = request.contentType else {
            return .next(request, response)
        }
        
        var request = request
        
        if case .buffer(let data) = request.body {
            switch (contentType.type, contentType.subtype) {
            case ("application", "json"):
                if let body = request.body.becomeBuffer() {
                    request.json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
                }
            default:
                break
            }
        }
        
        return .next(request, response)
    }
    
}
