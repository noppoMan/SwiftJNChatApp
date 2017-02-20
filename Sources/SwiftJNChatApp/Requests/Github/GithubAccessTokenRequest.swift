//
//  GithubAccessTokenRequest.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import Foundation
import APIKit

struct GithubAccessTokenRequest: APIKit.Request {
    
    typealias Response = GithubToken
    
    let params: Any
    
    init(params: Any){
        self.params = params
    }
    
    /// The base URL.
    public var baseURL: URL {
        return URL(string: "https://github.com")!
    }
    
    /// The path URL component.
    public var path: String {
        return "/login/oauth/access_token"
    }
    
    /// The HTTP request method.
    public var method: HTTPMethod {
        return .get
    }
    
    var headerFields: [String : String] {
        return ["Accept": "application/json"]
    }
    
    var parameters: Any? {
        return params
    }
    
    /// Build `Response` instance from raw response object. This method is called after
    /// `intercept(object:urlResponse:)` if it does not throw any error.
    /// - Throws: `ErrorType`
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let dict = object as? [String: String], let accessToken = dict["access_token"], let scope = dict["scope"], let type = dict["token_type"] else {
            throw GithubAPIError.couldNotGetAccessToken
        }
        
        return GithubToken(
            accessToken: accessToken,
            scope: scope,
            type: type
        )
    }
}

