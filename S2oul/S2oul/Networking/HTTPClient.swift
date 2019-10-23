//
//  HTTPClient.swift
//  S2oul
//
//  Created by 이현욱 on 11/10/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import Alamofire

protocol httpClientProvider {
    func get(url: String) -> DataRequest
}

final class HTTPClient: httpClientProvider {
    let baseURL = " "
    
    func get(url: String) -> DataRequest {
        return AF.request(baseURL + url,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          interceptor: nil)
    }
}
