//
//  Knex.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//


private var con: KnexConnection!

func knex() -> Knex {
    return Knex.knex()
}

extension Knex {
    
    public static func knex() -> Knex {
        return con.knex()
    }
    
    public static func createConnection() throws {
        con = try KnexConnection(config: Database.default.connectionInfo)
    }
    
    public func page(_ no: Int, limit: Int = 10) -> Self {
        return self.limit(limit).offset(no == 1 ? 0 : no-1*limit)
    }
}
