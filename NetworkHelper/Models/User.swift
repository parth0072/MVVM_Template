//
//  User.swift
//  NetworkHelper
//
//  Created by Parth on 09/10/20.
//  Copyright © 2020 Parth. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    let login: String
    let id: Double
    let avatar_url: String
    
    init(with json: JSON) {
        self.login = json["login"].stringValue
        self.id = json["id"].doubleValue
        self.avatar_url = json["avatar_url"].stringValue
    }
}
