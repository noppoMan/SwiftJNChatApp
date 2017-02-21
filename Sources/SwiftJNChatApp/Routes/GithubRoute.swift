//
//  GithubRoute.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import Foundation
import WebAppKit
import APIKit
import JWT

func githubRouter() -> Router {
    var router = Router()
    
    router.use(.get, "/auth/github") { request, response in
        var response = response
        let url = "https://github.com/login/oauth/authorize?scope=user:email,public_repo&client_id=\(Config.default.GITHUB_CLIENT_ID)"
        response.set(headerKey: "Location", value: url)
        response.status = .found
        
        return response
    }
    
    func githubTokenOauthRequest(code: String) throws -> GithubToken {
        let params = [
            "client_id": Config.default.GITHUB_CLIENT_ID,
            "client_secret": Config.default.GITHUB_CLIENT_SECRET,
            "code": code,
            "redirect_uri": Config.default.buildAbsoluteURLString("/auth/github/callback")
        ]
        
        let query = params.map({ "\($0.key)=\($0.value)" }).joined(separator: "&")
        
        var request = URLRequest(url: URL(string: "https://github.com/login/oauth/access_token?\(query)")!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return try URLSession.shared.dataTaskResumeSync(with: request)
    }
    
    func githubUserGetRequest(token: GithubToken) throws -> User {
        var request = URLRequest(url: URL(string: "https://api.github.com/user?access_token=\(token.accessToken)")!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return try URLSession.shared.dataTaskResumeSync(with: request)
    }
    
    router.use(.get, "/auth/github/callback") { request, response in
        guard let code = request.queryItems.filter({ $0.name == "code" }).first?.value else {
            throw GithubAPIError.invalidCode
        }
        
        let token = try githubTokenOauthRequest(code: code)
        var loginedUser = try githubUserGetRequest(token: token)
        
        let currentUser: User
        if let user: User = try knex().table("users").where("login" == loginedUser.login).fetch().first {
            currentUser = user
        } else {
            let result = try knex().insert(into: "users", values: loginedUser)
            loginedUser.id = Int32(result.insertId)
            currentUser = loginedUser
        }
        
        let jwt = JWT.encode(claims: ["user_id": currentUser.id, "expires": "\(Calendar.current.date(byAdding: .day, value: 1, to: Date())!)"], algorithm: .hs256(Config.default.jwtSecret.data(using: .utf8)!))
        let tpl = try Template(url: URL(string: "file://\(__dirname)/../../views/callback.html")!)
        
        var response = response
        try response.set(body: tpl.compile(["TOKEN": jwt, "currentUser": currentUser.serializeJSON()]))
    
        return response
    }
    
    return router
}
