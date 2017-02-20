import Foundation
import WebAppKit

func indexRouter() -> Router {
    var router = Router()
    
    router.use(.get, "/") { request, response in
        var response = response
        let data = try Data(contentsOf: URL(string: "file://\(__dirname)/../../views/index.html")!)
        response.set(body: data)
        return response
    }
    
    return router
}
