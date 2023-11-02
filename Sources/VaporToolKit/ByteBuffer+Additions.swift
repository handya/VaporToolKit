//
//  ByteBuffer+Additions.swift
//  
//
//  Created by Andrew Farquharson on 12/07/23.
//

import Vapor

extension ByteBuffer {
    var stringValue: String? {
        guard let data = self.getData(at: self.readerIndex, length: self.readableBytes) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}
