//
//  Request.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/20.
//
//


extension Prorsum.Request {
    
    var isAuthenticated: Bool {
        return currentUser != nil
    }
    
    var currentUser: User? {
        get {
            return storage["current_user"] as? User
        }
        
        set {
            return storage["current_user"] = newValue
        }
    }
    
    var json: [String: Any]? {
        get {
            return storage["body_json"] as? [String: Any]
        }
        
        set {
            storage["body_json"] = newValue
        }
    }
}
