import SwiftKnex
import Foundation

class Migration_20170220190429_CreateMessage: Migratable {
    var name: String {
        return "\(Mirror(reflecting: self).subjectType)"
    }

    func up(_ migrator: Migrator) throws {
        let user = Create(
            table: "messages",
            fields: [
                Schema.integer("id").asPrimaryKey().asAutoIncrement(),
                Schema.string("user_id").asIndex().asNotNullable(),
                Schema.text("text")
            ])
            .hasTimestamps()
        
        try migrator.run(user)
    }

    func down(_ migrator: Migrator) throws {
        try migrator.run(Drop(table: "messages"))
    }
}
