//
//  Content+VaporToolKit.swift
//  App
//
//  Created by Andrew Farquharson on 23/07/20.
//

import Vapor
import FluentPostgresDriver

public extension Content {
    static func rawQueryAll(_ query: String, on db: Database) -> EventLoopFuture<[Self]> {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).all(decoding: Self.self)
    }

    static func rawQueryFirst(_ query: String, on db: Database) -> EventLoopFuture<Self?> {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).first(decoding: Self.self)
    }

    static func rawQueryExists(_ query: String, on db: Database) -> EventLoopFuture<Bool> {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query))
            .first(decoding: Self.self)
            .map { $0 != nil }
    }
}
