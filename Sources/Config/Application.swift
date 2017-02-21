import Foundation

public enum SwiftEnv: String {
    case production = "production"
    case staging = "staging"
    case development = "development"
}

public struct Config {
    
    public static let `default` = Config()
    
    public let env = SwiftEnv(rawValue: ProcessInfo.processInfo.environment["SWIFT_ENV"] ?? "development") ?? SwiftEnv.development
    
    public func `env`(is swiftenv: SwiftEnv) -> Bool {
        return self.env == swiftenv
    }
    
    public var baseURL: String {
        return "http://localhost:3030"
    }
    
    public func buildAbsoluteURL(_ path: String) -> URL {
        return URL(string: self.buildAbsoluteURLString(path))!
    }
    
    public func buildAbsoluteURLString(_ path: String) -> String {
        return "\(baseURL)\(path)"
    }
    
    public var GITHUB_CLIENT_ID: String {
        return ProcessInfo.processInfo.environment["GITHUB_CLIENT_ID"]!
    }
    
    public var GITHUB_CLIENT_SECRET: String {
        return ProcessInfo.processInfo.environment["GITHUB_CLIENT_SECRET"]!
    }
    
    public var jwtSecret: String {
        return ProcessInfo.processInfo.environment["JWT_SECRET"]!
    }
}
