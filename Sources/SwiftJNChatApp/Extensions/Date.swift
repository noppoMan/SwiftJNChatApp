//
//  Date.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import Foundation

extension Date {
    func dateTimeString() -> String {
        struct statDFT {
            static var dateStringFormatter :  DateFormatter? = nil
            static var token : Int = 0
        }
        
        // TODO once
        statDFT.dateStringFormatter = DateFormatter()
        statDFT.dateStringFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss"
        statDFT.dateStringFormatter!.locale = Locale(identifier: "en_US_POSIX")
        
        return statDFT.dateStringFormatter!.string(from: self)
    }
}
