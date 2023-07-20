//
//  DateOrEmpty.swift
//  MovieApp
//
//  Created by Peter Woods on 7/20/23.
//

import Foundation

/// A property wrapper type which can be used in `Decodable` objects
/// to decode a date field which may also contain an empty string.
@propertyWrapper struct DateOrEmpty {
    let wrappedValue: Date?
}

// MARK: Decodable conformance

extension DateOrEmpty: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        self.wrappedValue = try? container.decode(Date.self)
    }
}
