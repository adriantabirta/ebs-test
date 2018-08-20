//
//  EbsError.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import Foundation

public struct EbsError: Error {
    
    // MARK: - Properties
    
    public let kind:         ErrorKind
    public let message:     String
    
    /// Retrieve the localized description for this error.
    public var localizedDescription: String {
        return "[\(kind.description)] - \(message)"
    }
    
    // MARK: - Types
    
    public enum ErrorKind: CustomStringConvertible {
        
        /// Unable to decode JSON.
        case jsonDecodeError
        
        /// Server error.
        case applicationError
        
        /// Error based on api.
        case invalidRequest
        
        /// No internet connection
        case unreachable
        
        public var description: String {
            switch self {
            case .jsonDecodeError:        return "jsonParseError"
            case .applicationError:        return "applicationError"
            case .invalidRequest:        return "invalidRequest"
            case .unreachable:          return "unreachableNetwork"
            }
        }
    }
}
