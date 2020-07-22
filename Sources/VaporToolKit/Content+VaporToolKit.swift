//
//  Content+VaporToolKit.swift
//  App
//
//  Created by Andrew Farquharson on 23/07/20.
//

import Vapor
import FluentPostgresDriver

public extension Content {
    public static func rawQueryAll<T: Content>(_ query: String, on req: Request) -> EventLoopFuture<[T]> {
        guard let sqldb = req.db as? SQLDatabase else {
            return req.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).all(decoding: T.self)
    }

    public static func rawQueryFirst<T: Content>(_ query: String, on req: Request) -> EventLoopFuture<T?> {
        guard let sqldb = req.db as? SQLDatabase else {
            return req.eventLoop.makeFailedFuture(Abort(.internalServerError))
        }
        return sqldb.raw(SQLQueryString(query)).first(decoding: T.self)
    }
}
