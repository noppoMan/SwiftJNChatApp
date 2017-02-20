//
//  GithubUserRequest.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import Foundation
import APIKit

struct GithubUserRequest: APIKit.Request {
    
    typealias Response = User
    
    let token: GithubToken
    
    init(token: GithubToken){
        self.token = token
    }
    
    /// The base URL.
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    /// The path URL component.
    public var path: String {
        return "/user"
    }
    
    /// The HTTP request method.
    public var method: HTTPMethod {
        return .get
    }
    
    var headerFields: [String : String] {
        return ["Accept": "application/json"]
    }
    
    var parameters: Any? {
        return ["access_token": token.accessToken]
    }
    
    /// Build `Response` instance from raw response object. This method is called after
    /// `intercept(object:urlResponse:)` if it does not throw any error.
    /// - Throws: `ErrorType`
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let dict = object as? [String: Any],
            let login = dict["login"] as? String,
            let avaterURL = dict["avatar_url"] as? String
            else {
            throw GithubAPIError.unsatisfiedBody("https://api.github.com/user")
        }
        
        return User(id: nil, login: login, name: dict["name"] as? String ?? login, avaterURL: avaterURL)
    }
}
