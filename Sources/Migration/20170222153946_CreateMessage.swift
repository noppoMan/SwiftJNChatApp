import SwiftKnex
import Foundation

class Migration_20170222153946_CreateMessage: Migratable {
    var name: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

    func up(_ migrator: Migrator) throws {
//        let tests = Create(
//            table: "tests",
//            fields: [
//                Schema.integer("id").asPrimaryKey().asAutoIncrement(),
//                Schema.string("name").asIndex().asNotNullable(),
//            ])
//            .hasTimestamps()
//
//        try migrator.run(tests)
    }

    func down(_ migrator: Migrator) throws {
//        try migrator.run(Drop(table: "tests"))
    }
}
