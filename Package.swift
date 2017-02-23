import PackageDescription

let package = Package(
    name: "SwiftJNChatApp",
    targets: [
        Target(name: "Config"),
        Target(name: "Migration", dependencies: ["Config"]),
        Target(name: "SwiftJNChatApp", dependencies: ["Config"])
    ],
    dependencies: [
        .Package(url: "https://github.com/noppoMan/WebAppKit.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/noppoMan/SwiftKnex.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/apple/swift-protobuf.git", Version(0,9,27)),
        .Package(url: "https://github.com/noppoMan/JSONWebToken.swift.git", Version(2,1,1))
    ]
)
