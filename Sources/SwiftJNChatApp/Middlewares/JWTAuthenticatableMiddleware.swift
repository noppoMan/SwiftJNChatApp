import Foundation
import WebAppKit
import JWT


enum JWTAuthenticatableMiddlewareError: Error {
    case invalidClaims
    case resourceNotFound
    case authorizationRequired
}

struct JWTAuthenticatableMiddleware: Middleware {
    
    public func respond(to request: Request, response: Response) throws -> Chainer {
        
        guard let authrozation = request.headers["Authorization"] else {
            throw JWTAuthenticatableMiddlewareError.authorizationRequired
        }
            
        let separated = authrozation.components(separatedBy: " ")
        
        guard separated.count >= 2 else {
            throw JWTAuthenticatableMiddlewareError.authorizationRequired
        }
        
        guard separated[0] == "JWT" else {
            throw JWTAuthenticatableMiddlewareError.authorizationRequired
        }
        
        let token = separated[1]
        
        let claims: ClaimSet = try JWT.decode(token, algorithm: .hs256(Config.default.jwtSecret.data(using: .utf8)!))
        
        guard let userId = claims["user_id"] as? Int else {
            throw JWTAuthenticatableMiddlewareError.invalidClaims
        }
        
        guard let user: User = try knex().table("users").where("id" == userId).fetch().first else {
            throw JWTAuthenticatableMiddlewareError.resourceNotFound
        }
        
        var request = request
        
        request.currentUser = user
        
        return .next(request, response)
    }
}
