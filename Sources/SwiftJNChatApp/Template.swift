//
//  Template.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/19.
//
//

import Foundation

class Template {
    let compiled: String
    
    init(url: URL) throws {
        let data = try Data(contentsOf: url)
        compiled = String(data: data, encoding: .utf8) ?? ""
    }
    
    func compile(_ templateData: [String: Any]) -> String {
        var html = compiled
        for data in templateData {
            html = html.replacingOccurrences(of: "{{\(data.key)}}", with: "\(data.value)")
        }
        return html
    }
}
