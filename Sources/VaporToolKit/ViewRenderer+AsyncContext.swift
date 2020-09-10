//
//  ViewRenderer+AsyncContext.swift
//  
//
//  Created by Andrew Farquharson on 11/09/20.
//

import Vapor

public extension ViewRenderer {
    func render<E>(_ name: String,
                          _ context: EventLoopFuture<E>) -> EventLoopFuture<View> where E: Encodable {
        context.flatMap { context in
            self.render(name, context)
        }
    }
}
