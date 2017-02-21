//
//  RPCRoute.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/20.
//
//

import Foundation
import WebAppKit

func messageRouter() -> Router {
    var router = Router()
    
    router.use(.get, "/message-poll", [JWTAuthenticatableMiddleware()]) { request, response in
        let lastId = request.queryItems
            .filter({ $0.name == "last_id" })
            .flatMap({ $0.value })
            .flatMap({ Int($0) }).first ?? 1
        
        let collection: MessageCollection? = try knex().table("messages")
            .select(
                col("messages.*"),
                col("users.id").as("u_id"),
                col("users.name").as("u_name"),
                col("users.login").as("u_login"),
                col("users.avatar_url").as("u_avatar_url")
            )
            .join("users")
            .on("users.id" == "messages.user_id")
            .where("users.id" != request.currentUser!.id)
            .where("messages.id" > lastId)
            .limit(10)
            .order(by: "id")
            .fetch()
        
        var response = response
        
        if let c = collection {
            try response.json(proto: c)
        } else {
            try response.json(["items": []])
        }
        
        return response
    }
    
    router.use(.get, "/messages", [JWTAuthenticatableMiddleware()]) { request, response in
        let collection: MessageCollection? = try knex().table("messages")
            .select(
                col("messages.*"),
                col("users.id").as("u_id"),
                col("users.name").as("u_name"),
                col("users.login").as("u_login"),
                col("users.avatar_url").as("u_avatar_url")
            )
            .join("users")
            .on("users.id" == "messages.user_id")
            .limit(30)
            .order(by: "id")
            .fetch()
        
        var response = response
        
        if let c = collection {
            try response.json(proto: c)
        } else {
            try response.json(["items": []])
        }
        
        return response
    }
    
    router.use(.post, "/messages", [JWTAuthenticatableMiddleware()]) { request, response in
        guard let text = request.json?["text"] as? String else {
            throw ValidationError.required("text")
        }
        
        let message = Message(user: request.currentUser!, text: text)
        let result = try knex().insert(into: "messages", values: message)
        
        var response = response
        response.status = .created
        response.set(body: "{\"id\": \(result.insertId)}")
        response.set(headerKey: "Content-Type", value: "application/json")
        
        return response
    }
    
    return router
    
}
