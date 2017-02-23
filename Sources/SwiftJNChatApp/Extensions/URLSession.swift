//
//  Session.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/19.
//
//

import Foundation

extension URLSession {
    func dataTaskResumeSync<T: Entity>(with request: URLRequest) throws -> T {
        let wg = WaitGroup()
        
        wg.add(1)
        
        var _error: Error?
        var result: T?
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer {
                wg.done()
            }
            
            if let e = error {
                _error = e
                return
            }
            
            do {
                if let dict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    result = try T(row: dict)
                }
            } catch {
                _error = error
            }
        }
        
        task.resume()
        
        wg.wait()
        
        if let error = _error {
            throw error
        }
        
        return result!
    }
}
