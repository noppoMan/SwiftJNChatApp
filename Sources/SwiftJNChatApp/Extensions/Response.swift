//
//  Request+JSON.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/20.
//
//

import Foundation
import SwiftProtobuf

extension Prorsum.Response {
    public mutating func json<T: SwiftProtobuf.Message>(proto pb: T) throws {
        try self.set(body:  pb.serializeJSON())
        self.set(headerKey: "Content-Type", value: "application/json")
    }
    
    public mutating func json(_ value: Any) throws {
        try self.set(body: JSONSerialization.data(withJSONObject: value, options: []))
        self.set(headerKey: "Content-Type", value: "application/json")
    }
}
