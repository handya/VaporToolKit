//
//  Color.swift
//
//
//  Created by Andrew Farquharson on 31/03/21.
//

import Vapor

public struct Color: Content {
    private let value: String

    public init(_ hex: String) {
        if hex.hasPrefix(String.hash) {
            self.value = hex
        } else {
            self.value = String.hash + hex
        }
    }

    public var rawHexValue: String {
        return value
    }
}

public extension Color {
    func withAlphaComponent(_ alpha: Float) -> Color {
        var result: String = value
        if result.hasPrefix(String.hash) {
            result = String(result.dropFirst())
        }
        if result.count == 8 {
            result = String(result.dropLast(2))
        }
        let scaledAlpha: Int = Int((255 * alpha / 100) * 100)
        var hexAlpha: String = String(scaledAlpha, radix: 16)
        if hexAlpha.count == 1 {
            hexAlpha = "0" + hexAlpha
        }
        return Color(result + hexAlpha)
    }
}

// MARK: - Constants

public extension Color {
    static let white: Color = .init("ffffff")
    static let black: Color = .init("000000")
    static let label: Color = .init("000000")
    static let secondaryLabel: Color = .init("3C3C4399")
    static let tertiaryLabel: Color = .init("3C3C434D")
    static let groupedBackground: Color = .init("F2F2F7")
    static let quaternaryLabel: Color = .init("3C3C432E")
    static let placeholderText: Color = .init("3C3C434D")
    static let separator: Color = .init("3C3C434A")
    static let opaqueSeparator: Color = .init("C6C6C8")
    static let link: Color = .init("007AFF")
    static let systemBlue: Color = .init("007AFF")
    static let systemGreen: Color = .init("34C759")
    static let systemIndigo: Color = .init("5856D6")
    static let systemOrange: Color = .init("FF9500")
    static let systemPink: Color = .init("FF2D55")
    static let systemPurple: Color = .init("AF52DE")
    static let systemRed: Color = .init("FF3B30")
    static let systemTeal: Color = .init("5AC8FA")
    static let systemYellow: Color = .init("FFCC00")
    static let systemMint: Color = .init("00C7BE")
    static let systemCyan: Color = .init("32ADE6")
    static let systemBrown: Color = .init("A2845E")
    static let systemGray: Color = .init("8E8E93")
    static let systemGray2: Color = .init("AEAEB2")
    static let systemGray3: Color = .init("C7C7CC")
    static let systemGray4: Color = .init("D1D1D6")
    static let systemGray5: Color = .init("E5E5EA")
    static let systemGray6: Color = .init("F2F2F7")
}

// MARK: - Encodable

extension Color: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if value.hasPrefix(String.hash) {
            try container.encode(value)
        } else {
            try container.encode(String.hash + value)
        }
    }
}

// MARK: - Decodable

extension Color: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        if rawValue.hasPrefix(String.hash) {
            self.value = String(rawValue.dropFirst())
        } else {
            self.value = rawValue
        }
    }
}

private extension String {
    static let hash: String = "#"
}
