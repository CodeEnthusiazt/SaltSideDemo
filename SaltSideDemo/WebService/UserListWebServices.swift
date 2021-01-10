//
//  UserListWebServices.swift
//  SaltSideDemo
//
//  Created by Dinesh on 09/01/21.
//

import Foundation
import Alamofire

class UserListWebServices {
    /// Get User List from server
    /// - Parameters:
    ///   - processSuccess: Clsoure for success handler
    ///   - processFailure: Closure for failure handler
    static func getUserList(processSuccess: @escaping ([UserModel]) -> Void, processFailure: @escaping () -> Void) {
        
        /// DataResponse completion handler
        /// - Parameter data: Response with userlist in success case or error in failure case
        func response(data: AFDataResponse<Any>) {
            switch data.result {
            case .success(_):
                do {
                    let userList = try JSONDecoder().decode([UserModel].self, from: data.data ?? Data())
                    processSuccess(userList)
                } catch {
                    processFailure()
                }
            default:
                processFailure()
            }
        }
        AlamofireWrapper.AFRequest(url: AppConstants.Url.listpage, response: response)
    }
}
