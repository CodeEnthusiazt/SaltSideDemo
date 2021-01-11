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
    /// Toggle Activityindicatior view Publiser
    @Published var toggleInteraction = true
    /// [UserModel] publisher
    var userListPublisher = PassthroughSubject<[UserModel], Never>()    
    /// Alert publisher
    var showAlert = PassthroughSubject<String, Never>()
    /// GetUserList from webservice
    func getUserList() {
        self.toggleInteraction = false
        weak var this = self
        /// Closure for success handler
        /// - Parameter res: User list data
        func proccessSuccess(res: [UserModel]) {
            guard let ui = this else {return}
            ui.toggleInteraction = true
            ui.userListPublisher.send(res)
        }
        /// Closure for failure handler
        func proccessFailure(errStr: String) {
            guard let ui = this else {return}
            ui.toggleInteraction = true
            ui.showAlert.send(errStr)
        }
        UserListWebServices.getUserList(processSuccess: proccessSuccess, processFailure: proccessFailure)
    }
}
