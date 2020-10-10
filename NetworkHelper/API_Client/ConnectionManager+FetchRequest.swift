//
//  ConnectionManager+FetchRequest.swift
//  Coda
//
//  Created by Parth on 02/01/19.
//  Copyright © 2019 stl-011. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

extension ConnectionManager {
    class func getUser(since:String,completion: @escaping ( _ result: JSON?, _ error : Error?) -> Void) ->Void{
        let urlLogin = "\(APIConstants.user())?since=\(since)"
        //        let param :Parameters =  ["since": since]
        let encodedUrl = urlLogin.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.fetchJson(urlString: encodedUrl, methodType:.get ,param : nil, headerInfo : header) { (data, er) in
            completion(data,er)
        }
    }
    
    class func getUser(user:String,completion: @escaping ( _ result: JSON?, _ error : Error?) -> Void) ->Void{
        let urlLogin = "\(APIConstants.user())/\(user)"
        //        let param :Parameters =  ["since": since]
        let encodedUrl = urlLogin.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.fetchJson(urlString: encodedUrl, methodType:.get ,param : nil, headerInfo : header) { (data, er) in
            completion(data,er)
        }
    }
}


