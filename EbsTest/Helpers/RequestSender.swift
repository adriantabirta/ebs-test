//
//  RequestSender.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import UIKit

class RequestSender: NSObject {

    private let baseURL = "http://185.181.231.23:3000"
    
    public typealias EmptySuccessHandler     = () -> Void
    public typealias SuccessHandler<T>       = (_ data: T) -> Void
    public typealias FailureHandler          = (_ error: EbsError?) -> Void
    
    /// Default url session for requests.
    fileprivate lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    fileprivate var headers: [String: String] {
        return [ "accept": "application/json"]
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    func send<T: Decodable>(_ request: RequestType, success: SuccessHandler<T?>?, failure: FailureHandler?) {
    
        if !EbsTest.shared.reachabilitySwift.isReachable  {
            failure?(EbsError(kind: EbsError.ErrorKind.unreachable, message: "Looks like you are offline."))
        }

        guard let url = URL(string: baseURL + request.path) else { return } // todo: print error
        
        var urlRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 10.0)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        session.dataTask(with: urlRequest) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else { return }
            
            switch response.statusCode {
            case 200:
                if let data = data {
                    
                    print("Raw response: ", String(data: data, encoding: String.Encoding.utf8) ?? "empty response body")
                    
                    DispatchQueue.global(qos: .utility).async {
                        do {
                            let object = try JSONDecoder().decode(T.self, from: data)
                            DispatchQueue.main.async {
                                success?(object)
                            }
                        } catch {
                            DispatchQueue.main.async {
                                failure?(EbsError(kind: EbsError.ErrorKind.jsonDecodeError, message: error.localizedDescription))
                            }
                        }
                    }
                }
                
            case 400, 401: failure?(EbsError(kind: EbsError.ErrorKind.invalidRequest, message: "Invalid input"))
            case 500: failure?(EbsError(kind: EbsError.ErrorKind.applicationError, message: "Server error. Status code 500"))
            default: break
            }
        }.resume()
    }
}
