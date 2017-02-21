import SwiftKnex
import Foundation

class Migration_20170218035306_CreateUser: Migratable {
    var name: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

    func up(_ migrator: Migrator) throws {
        let user = Create(
            table: "users",
            fields: [
                Schema.integer("id").asPrimaryKey().asAutoIncrement(),
                Schema.string("login").asUnique().asNotNullable(),
                Schema.string("name"),
                Schema.string("avatar_url")
            ])
            .hasTimestamps()

        try migrator.run(user)
    }

    func down(_ migrator: Migrator) throws {
        try migrator.run(Drop(table: "users"))
    }
}
