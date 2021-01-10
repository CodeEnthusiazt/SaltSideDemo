//
//  ListDataSource.swift
//  SaltSideDemo
//
//  Created by Dinesh on 10/01/21.
//

import Foundation
import UIKit

class ListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var userList: [UserModel] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TVIdentifier.listId, for: indexPath) as? ListTVCell {
            cell.configure(user: userList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
}
