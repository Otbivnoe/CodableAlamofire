//
//  AlamofireDecodableError.swift
//  CodableAlamofire
//
//  Created by Nikita Ermolenko on 11/06/2017.
//

import Foundation

/// `AlamofireDecodableError` is the error type returned by CodableAlamofire.
///
/// - invalidKeyPath:   Returned when a nested dictionary object doesn't exist by special keyPath.
/// - emptyKeyPath:     Returned when a keyPath is empty.
/// - invalidJSON:      Returned when a nested json is invalid.

public enum AlamofireDecodableError: Error {
    case invalidKeyPath
    case emptyKeyPath
    case invalidJSON
}

extension AlamofireDecodableError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidKeyPath:   return "Nested object doesn't exist by this keyPath."
        case .emptyKeyPath:     return "KeyPath can not be empty."
        case .invalidJSON:      return "Invalid nested json."
        }
    }
}
