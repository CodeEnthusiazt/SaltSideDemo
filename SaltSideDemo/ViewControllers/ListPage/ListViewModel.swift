//
//  ListViewModel.swift
//  SaltSideDemo
//
//  Created by Dinesh on 10/01/21.
//

import Foundation
import Combine

class ListViewModel {
    /// DataService to hold usermodel data
    var dataservices = ListDataSource()
    /// Toggle Activityindicatior view
    @Published var toggleInteraction = true
    /// [UserModel] publisher
    var userListPublisher = PassthroughSubject<[UserModel], Never>()    

    /// GetUserList from webservice
    func getUserList() {
        self.toggleInteraction = false
        
        /// Closure for success handler
        /// - Parameter res: User list data
        func proccessSuccess(res: [UserModel]) {
            toggleInteraction = true
            self.userListPublisher.send(res)
        }
        /// Closure for failure handler
        func proccessFailure() {
            toggleInteraction = true
        }
        UserListWebServices.getUserList(processSuccess: proccessSuccess, processFailure: proccessFailure)
    }
}
