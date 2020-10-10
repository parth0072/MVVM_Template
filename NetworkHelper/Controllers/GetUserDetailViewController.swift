//
//  GetUserDetailViewController.swift
//  NetworkHelper
//
//  Created by Parth on 10/10/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import UIKit
import Combine

class GetUserDetailViewController: UIViewController {
    
    let userVm = UserViewModel()
    var cancellable = Set<AnyCancellable>()
    var userName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userVm.getUserDetails(userName: userName)
        userVm.$userDetails.sink { (user) in
            print(user?.login)
        }.store(in: &cancellable)
    }
}
