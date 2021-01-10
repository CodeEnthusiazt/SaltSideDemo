//
//  AlamofireWrapper.swift
//  SaltSideDemo
//
//  Created by Dinesh on 10/01/21.
//

import Foundation
import Alamofire

class AlamofireWrapper {
    class func AFRequest(url: URLConvertible, method: HTTPMethod = .get, paramerter: [String: Any]? = nil, encoding: URLEncoding = .default, headers: HTTPHeaders? = nil, response: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url, method: method, parameters: paramerter, encoding: encoding, headers: headers)
            .responseJSON { result in
                response(result)
            }
    }
}
