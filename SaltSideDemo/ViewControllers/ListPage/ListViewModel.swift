//
//  ListViewModel.swift
//  SaltSideDemo
//
//  Created by Dinesh on 10/01/21.
//

import Foundation
import Combine

class ListViewModel {
    var dataservices = ListDataSource()
    @Published var toggleInteraction = true
    var userListPublisher = PassthroughSubject<[UserModel], Never>()    

    func getUserList() {
        self.toggleInteraction = false
        func proccessSuccess(res: [UserModel]) {
            toggleInteraction = true
            self.userListPublisher.send(res)
        }
        func proccessFailure() {
            toggleInteraction = true
        }
        UserListWebServices.getUserList(processSuccess: proccessSuccess, processFailure: proccessFailure)
    }
}
