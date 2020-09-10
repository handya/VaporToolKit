//
//  SQLQueryFetcher+VaporToolKit.swift
//  App
//
//  Created by Andrew Farquharson on 18/05/20.
//
// swiftlint:disable large_tuple

import FluentPostgresDriver

public extension SQLQueryFetcher {
    func first<A, B>(decoding: A.Type, _ b: B.Type) -> EventLoopFuture<(A, B)?> where A: Decodable, B: Decodable {
        self.first().flatMapThrowing {
            guard let row = $0 else {
                return nil
            }
            let a = try row.decode(model: A.self)
            let b = try row.decode(model: B.self)
            return (a, b)
        }
    }

    func first<A, B, C>(decoding: A.Type, _ b: B.Type, _ c: C.Type) -> EventLoopFuture<(A, B, C)?> where A: Decodable, B: Decodable, C: Decodable {
        self.first().flatMapThrowing {
            guard let row = $0 else {
                return nil
            }
            let a = try row.decode(model: A.self)
            let b = try row.decode(model: B.self)
            let c = try row.decode(model: C.self)
            return (a, b, c)
        }
    }

    func all<A, B>(decoding: A.Type, _ b: B.Type) -> EventLoopFuture<[(A, B)]> where A: Decodable, B: Decodable {
        self.all().flatMapThrowing {
            try $0.map {
                let a = try $0.decode(model: A.self)
                let b = try $0.decode(model: B.self)
                return (a, b)
            }
        }
    }

    func all<A, B, C>(decoding: A.Type, _ b: B.Type, _ c: C.Type) -> EventLoopFuture<[(A, B, C)]> where A: Decodable, B: Decodable, C: Decodable {
        self.all().flatMapThrowing {
            try $0.map {
                let a = try $0.decode(model: A.self)
                let b = try $0.decode(model: B.self)
                let c = try $0.decode(model: C.self)
                return (a, b, c)
            }
        }
    }
}
// swiftlint:enable large_tuple
