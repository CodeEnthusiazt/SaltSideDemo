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
                    let userList = try JSONDecoder().decode([UserModel].self, from: data.value as? Data ?? Data())
                    processSuccess(userList)
                } catch {
                    processFailure()
                }
            default:
                print("")
            }
        }
        AlamofireWrapper.AFRequest(url: AppConstants.Url.listpage, response: response)
    }
}
