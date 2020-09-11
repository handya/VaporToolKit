//
//  QueryBuilder+VaporToolKit.swift
//  App
//
//  Created by Andrew Farquharson on 23/07/20.
//

import Fluent

public extension QueryBuilder {
    func exists() -> EventLoopFuture<Bool> {
        return self.limit(1)
            .all()
            .map { $0.first != nil }
    }

    func first(or error: Error) -> EventLoopFuture<Model> {
        return self.limit(1)
            .all()
            .map { $0.first }
            .unwrap(or: error)
    }
}
