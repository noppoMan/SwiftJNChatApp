//
//  MessageCollection.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/20.
//
//

extension MessageCollection: SwiftKnex.CollectionType {
    
    public init(rows: ResultSet) throws {
        self.init()
        self.items = try rows.map({ try Message(row: $0) })
    }
    
}
