//
//  MessageCollection.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/20.
//
//

extension MessageCollection: SwiftKnex.CollectionType {
    
    public init(rows: ResultSet) throws {
        let rows = try rows.map({ try Message(row: $0) })
        self.init(items: rows)
    }
    
}
