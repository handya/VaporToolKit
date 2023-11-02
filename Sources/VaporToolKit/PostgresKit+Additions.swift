//
//  Error+PostgresError.swift
//
//
//  Created by Andrew Farquharson on 3/11/23.
//

import PostgresKit

extension Error {
    func isConstraintError(_ constraintName: String) -> Bool {
        if let postgresError = self as? PostgresError,
           case .server(let error) = postgresError,
           error.fields.first(where: { $0.key == .constraintName })?.value == constraintName {
            return true
        } else if let postgresError = self as? PSQLError, postgresError.serverInfo?[.constraintName] == constraintName {
            return true
        } else {
            return false
        }
    }
}
