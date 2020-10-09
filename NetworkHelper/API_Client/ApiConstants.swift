//
//  ApiConstants.swift
//  Coda
//
//  Created by Parth on 1/2/19.
//  Copyright © 2019 stl-011. All rights reserved.
//

import Foundation
class APIConstants:NSObject{
    static func user() -> String {
        return API.baseURL + API.USER
    }
}
struct API {
    
    static let baseURL = "https://api.github.com/"
    static let USER = "users"
}
