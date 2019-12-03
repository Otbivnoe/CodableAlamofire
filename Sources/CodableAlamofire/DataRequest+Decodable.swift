//
//  DataRequest+Decodable.swift
//  CodableAlamofire
//
//  Created by Nikita Ermolenko on 10/06/2017.
//  Copyright © 2017 Nikita Ermolenko. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {

    /// Adds a handler to be called once the request has finished.
     
    /// - parameter queue:             The queue on which the completion handler is dispatched. Default: `.main`.
    /// - parameter keyPath:           The keyPath where object decoding should be performed. Default: `nil`.
    /// - parameter decoder:           The decoder that performs the decoding of JSON into semantic `Decodable` type. Default: `JSONDecoder()`.
    /// - parameter completionHandler: The code to be executed once the request has finished and the data has been mapped by `JSONDecoder`.
     
    /// - returns: The request.
    
    @discardableResult
    public func responseDecodableObject<T: Decodable>(queue: DispatchQueue = .main,
                                                      keyPath: String? = nil,
                                                      decoder: JSONDecoder = JSONDecoder(),
                                                      completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: DataKeyPathSerializer<T>(keyPath: keyPath, decoder: decoder),
                        completionHandler: completionHandler)
    }
}
