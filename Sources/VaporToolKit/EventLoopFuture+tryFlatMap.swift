//
//  EventLoopFuture+tryFlatMap.swift
//  
//
//  Created by Andrew Farquharson on 11/09/20.
//

import NIO

/// Author: vzsg (Discord) - https://twitter.com/vzsg_dev
/// Source: https://discordapp.com/channels/431917998102675485/684159753189982218/684537099378098272
public extension EventLoopFuture {
    func tryFlatMap<NewValue>(_ callback: @escaping (Value) throws -> EventLoopFuture<NewValue>) -> EventLoopFuture<NewValue> {
        return flatMap { result in
            do {
                return try callback(result)
            } catch {
                return self.eventLoop.makeFailedFuture(error)
            }
        }
    }
}
