@_exported import SwiftKnex
@_exported import Prorsum
@_exported import Config
import WebAppKit
import SwiftProtobuf
import Foundation

let env = DotEnv(withFile: ".env")

let __dirname = #file.characters
    .split(separator: "/", omittingEmptySubsequences: false)
    .dropLast(1)
    .map { String($0) }
    .joined(separator: "/")

try Knex.createConnection()

let app = Ace()
var router = Router()

app.use(ServeStaticMiddleware(root: "\(__dirname)/../../public"))
app.use(JSONParserMiddleware())

app.use(githubRouter())
app.use(messageRouter())
app.use(indexRouter())

// handler errors
app.catch { error in
    switch error {
    case ServeStaticMiddlewareError.resourceNotFound(let path):
        return Response(status: .notFound, body: .buffer("\(path) is not found".data))
        
    case RouterError.routeNotFound(let path):
        return Response(status: .notFound, body: .buffer("\(path) is not found".data))
        
    case JWTAuthenticatableMiddlewareError.authorizationRequired:
        return Response(
            status: .unauthorized,
            headers: ["Content-Type": "application/json"],
            body: .buffer("{\"error\": \"Autorization Required\"}".data)
        )
    
    default:
        print(error)
        return Response(status: .internalServerError, body: .buffer("Internal Server Error".data))
    }
}

let server = try HTTPServer(app.handler)
try server.bind(host: "localhost", port: 3030)
try server.listen()
print("Server listening at localhost:3030")

RunLoop.main.run()
