//
//  Errors.swift
//  CodableAlamofire-iOS
//
//  Created by Nikita Ermolenko on 11/06/2017.
//

import Foundation

public enum AlamofireDecodableError: Error {
    case invalidKeyPath
    case emptyKeyPath
}

extension AlamofireDecodableError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidKeyPath:   return "Nested object doesn't exist by this KeyPath."
        case .emptyKeyPath:     return "KeyPath can not be empty."
        }
    }
}
