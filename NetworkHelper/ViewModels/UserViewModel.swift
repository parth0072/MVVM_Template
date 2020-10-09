//
//  UserViewModel.swift
//  NetworkHelper
//
//  Created by Parth on 09/10/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import Foundation

class UserViewModel {
    
    init() { }
    
    func getUserList(completion: @escaping (_ success: [User]?, _ error: Error?) -> Void) {
        ConnectionManager.getUser(since: "135") { (json, error) in
            let users = json?.array
            let usersObj = users?.compactMap{ User.init(with: $0)}
            completion(usersObj,nil)
        }
    }
}
