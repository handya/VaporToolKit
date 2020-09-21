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

    static func rawQueryAll<A>(_ query: String, alsoDecode: A.Type, on db: Database) -> EventLoopFuture<[(Self, A)]> where A: Decodable {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).all(decoding: Self.self, A.self)
    }

    static func rawQueryFirst(_ query: String, on db: Database) -> EventLoopFuture<Self?> {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).first(decoding: Self.self)
    }

    static func rawQueryFirst<A>(_ query: String, alsoDecode: A.Type, on db: Database) -> EventLoopFuture<(Self, A)?> where A: Decodable {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).first(decoding:  Self.self, A.self)
    }

    static func rawQueryExists(_ query: String, on db: Database) -> EventLoopFuture<Bool> {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query))
            .first(decoding: Self.self)
            .map { $0 != nil }
    }

    static func runRawQuery(_ query: String, on db: Database) -> EventLoopFuture<Void> {
        guard let sqldb = db as? SQLDatabase else {
            return db.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).run()
    }
}
