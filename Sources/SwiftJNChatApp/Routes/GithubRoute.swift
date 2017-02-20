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
    
    router.use(.get, "/auth/github/callback") { request, response in
        guard let code = request.queryItems.filter({ $0.name == "code" }).first?.value else {
            throw GithubAPIError.invalidCode
        }
        
        let params = [
            "client_id": Config.default.GITHUB_CLIENT_ID,
            "client_secret": Config.default.GITHUB_CLIENT_SECRET,
            "code": code,
            "redirect_uri": Config.default.buildAbsoluteURL("/auth/github/callback")
        ]

        let accessTokenRequest = GithubAccessTokenRequest(params: params)
        
        let token = try Session.sendSync(accessTokenRequest)
        var loginedUser = try Session.sendSync(GithubUserRequest(token: token))
        
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
