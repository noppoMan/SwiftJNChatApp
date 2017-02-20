//
//  main.swift
//  SwiftJNChatApp
//
//  Created by Yuki Takei on 2017/02/18.
//
//

import SwiftKnex
import Config

let knexMigrations: [Migratable] = [
    Migration_20170218035306_CreateUser(),
    Migration_20170220190429_CreateMessage()
]

try Migrator.run(config: Database.default.connectionInfo, arguments: CommandLine.arguments, knexMigrations: knexMigrations)

