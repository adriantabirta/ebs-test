//
//  Requests.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import Foundation

enum RequestType {
    
    case products(offest: Int, limit: Int)
    case product(id: Int)
    
    var path: String {
        switch self {
        case .products(offest: let offset, limit: let limit):   return "/products?offset=\(offset)&limit=\(limit)"
        case .product(id: let id):                              return "/product?id=\(id)"
        }
    }
    
    var method: RequestSender.HTTPMethod {
        return .get
    }
}
