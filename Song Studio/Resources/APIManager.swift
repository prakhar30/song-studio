//
//  APIManager.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 31/10/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class SRLAPIManager {
    static let shared = SRLAPIManager()
    var sessionManager = SessionManager()
    
    func get_requestURL(urlString: String,
                        headers: [String: String]?,
                        params: [String: String]? = nil,
                        success: @escaping (JSON) -> Void,
                        failure: @escaping (String) -> Void) {
        
        self.sessionManager.request(urlString,
                                    method: .get,
                                    parameters: params,
                                    encoding: URLEncoding.default,
                                    headers: headers)
            .responseJSON { (responseObject) -> Void in
                self.handleResponse(responseObject: responseObject,
                                    success: success,
                                    failure: failure)
        }
    }
    
    func handleResponse(responseObject: DataResponse<Any>,
                        success: @escaping (JSON) -> Void,
                        failure: @escaping (String) -> Void) {
        
        if responseObject.result.isSuccess {
            guard let responseSerialization = responseObject.result.value, let serverResponse = responseObject.response else {
                failure("Unable to serialize data.")
                return
            }
            let resJson = JSON(responseSerialization)
            guard let statusCode: HTTPStatusCode = HTTPStatusCode(serverResponse.statusCode) else {
                failure("No status code found.")
                return
            }
            
            if statusCode.isSuccess {
                success(resJson)
            }
        } else if responseObject.result.isFailure {
            let _: NSError = responseObject.result.error! as NSError
            failure("")
        }
    }
}
