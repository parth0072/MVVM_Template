

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class ConnectionManager: NSObject {
    
    static var header:HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    static var manager: Session?
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        ConnectionManager.manager = Session.init(configuration: configuration)
    }
    
    
    class func fetchJson(urlString : String?, methodType : HTTPMethod? , param : Dictionary<String,Any>? , headerInfo :  HTTPHeaders? , completion: @escaping (_ result: JSON, _ error : Error?) -> Void)
    {
        guard self.validateURL(urlString: urlString) else {
            completion(JSON.null, NSError(domain: "Invalid url String", code: 0, userInfo: nil))
            return
        }
        // Add further url verification codes here
        let _ =  self.fetchDataRequest(urlString : urlString!, methodType:methodType , parameters:param,headerInfo : headerInfo,shouldStartImmediately:true){ (data, er) in
            completion(data,er)
        }
    }
    
    //MARK:- JSON_DATA_TASK url
    class func fetchDataRequest(urlString : String,
                                methodType : HTTPMethod?,
                                parameters:Dictionary<String,Any>?,
                                headerInfo:HTTPHeaders?,
                                shouldStartImmediately : Bool,
                                completion: @escaping (_ result: JSON, _ error : Error?) -> Void) -> DataRequest?
    {
        
        let mType:HTTPMethod = methodType!
        let dataReq : DataRequest
        switch mType {
        case HTTPMethod.get :
            dataReq = AF.request(urlString,
                                 method: mType,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: headerInfo)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let  json = JSON(value)
                        completion(json, nil)
                    case .failure(let error):
                        completion(JSON.null, error)
                    }
            }
            if(shouldStartImmediately)
            {
                dataReq.resume()
            }
            return dataReq
        case HTTPMethod.put :
            dataReq = AF.request(urlString,
                                 method: mType,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: headerInfo)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let  json = JSON(value)
                        completion(json, nil)
                    case .failure(let error):
                        completion(JSON.null, error)
                    }
            }
            if(shouldStartImmediately)
            {
                dataReq.resume()
            }
            return dataReq
        case HTTPMethod.post :
            dataReq = AF.request(urlString,
                                 method: mType,
                                 parameters: parameters,
                                 encoding: URLEncoding.queryString,
                                 headers: headerInfo)
                //            .validate(statusCode: 200..<300)
                // .validate(contentType: ["application/json"])
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let  json = JSON(value)
                        completion(json, nil)
                    case .failure(let error):
                        completion(JSON.null, error)
                    }
            }
            return dataReq
        default:
            return nil
        }
    }
    
    //MARK:- Extras
    class func validateURL(urlString : String?) -> Bool
    {
        // Add further url verification codes here
        guard urlString != nil && (urlString?.checkURL())! else {
            return false
        }
        return true
    }
    
    
}
extension String {
    func getFullyTrimmedString()->String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getFullyTrimmedStringLength()->Int{
        return self.getFullyTrimmedString().count
    }
    
    func checkURL() -> Bool {
        guard (self.getFullyTrimmedStringLength()) > 0 else{
            return  false
        }
        
        let urlRegEx = "^http(?:s)?://(?:w{3}\\.)?(?!w{3}\\.)(?:[\\p{L}a-zA-Z0-9\\-]+\\.){1,}(?:[\\p{L}a-zA-Z]{2,})/(?:\\S*)?$"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        
        return urlTest.evaluate(with: self)
    }
    
    
    
    
}
