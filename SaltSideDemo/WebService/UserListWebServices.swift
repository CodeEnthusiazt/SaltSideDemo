//
//  UserListWebServices.swift
//  SaltSideDemo
//
//  Created by Dinesh on 09/01/21.
//

import Foundation
import Alamofire

enum ApiError: String {
    case decodingError
    case ApiFailed
}

class UserListWebServices {
    /// Get User List from server
    /// - Parameters:
    ///   - processSuccess: Clsoure for success handler with [UserModel]
    ///   - processFailure: Closure for failure handler with error
    static func getUserList(processSuccess: @escaping ([UserModel]) -> Void, processFailure: @escaping (String) -> Void) {
        
        /// DataResponse completion handler
        /// - Parameter data: Response with userlist in success case or error in failure case
        func response(data: AFDataResponse<Any>) {
            switch data.result {
            case .success(_):
                do {
                    let userList = try JSONDecoder().decode([UserModel].self, from: data.data ?? Data())
                    processSuccess(userList)
                } catch {
                    processFailure(ApiError.decodingError.rawValue)
                }
            default:
                processFailure(ApiError.ApiFailed.rawValue)
            }
        }
        AlamofireWrapper.AFRequest(url: AppConstants.Url.listpage, response: response)
    }
}
