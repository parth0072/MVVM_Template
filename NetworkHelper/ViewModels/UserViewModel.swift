//
//  UserViewModel.swift
//  NetworkHelper
//
//  Created by Parth on 09/10/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import Foundation
import Combine

class UserViewModel {
    
    var getUserList : ((_ success: [User]?, _ error: Error?) -> Void)?
    
    @Published var users = [User]()
    
    @Published var error: Error?
    
    @Published var userDetails: User?
    
    init() { }
    
    func fetchUserList() {
        ConnectionManager.getUser(since: "135") { (json, error) in
            let users = json?.array
            let usersObj = users?.compactMap{ User.init(with: $0)}
            self.users = usersObj ?? []
            self.error = error
            self.getUserList?(usersObj, nil)
        }
    }
    
    func getUserDetails(userName: String) {
        ConnectionManager.getUser(user: userName) { (json, error) in
            if error == nil {
                let user = User.init(with: json!)
                self.userDetails = user
            }else{
                self.error = error
            }
        }
    }
}
