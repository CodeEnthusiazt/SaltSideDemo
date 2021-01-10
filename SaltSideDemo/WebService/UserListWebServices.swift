//
//  UserListWebServices.swift
//  SaltSideDemo
//
//  Created by Dinesh on 09/01/21.
//

import Foundation
import Alamofire

class UserListWebServices {
    static func getUserList(processSuccess: @escaping ([UserModel]) -> Void, processFailure: @escaping () -> Void) {
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
