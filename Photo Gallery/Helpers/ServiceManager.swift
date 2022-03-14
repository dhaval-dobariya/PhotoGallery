//
//  ServiceManager.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import Alamofire
import UIKit

class ServiceManager: NSObject {

    static let shared = ServiceManager()
    static let REQUEST_TIMEOUT: TimeInterval = 30
    
    private var reachability: NetworkReachabilityManager!

    /// To prevent creating object for this class
    private override init() {
        super.init()
        
        reachability = NetworkReachabilityManager.default
        monitorReachability()
    }
    
    /// To fire API call
    ///  - Parameter apiName: String - Name of API mostly last path like /profile
    ///  - Parameter headers: HTTPHeaders - Pass headers if needed else null
    ///  - Parameter method: HTTPMethod - API calling method like get, post, put, etc.
    ///  - Parameter parameters: [String: Any]? - Parameters if needed else null
    ///  - Parameter successBlock - CompletionBlock with response Data
    ///  - Parameter errorBlock - CompletionBlock with error message
    func performRequest(withAPIName apiName: String, headers: HTTPHeaders? = nil, method: HTTPMethod, parameters: [String: Any]? = nil, successBlock:@escaping(_ response: Data) -> Void, errorBlock:@escaping(_ message: String) -> Void) {
        
        if reachability.isReachable {
            guard let url = URL(string: Constants.URL.BaseURL.appending(apiName)) else { return }
            
            var requestHeaders: HTTPHeaders
            if let headers = headers {
                requestHeaders = headers
            } else {
                requestHeaders = HTTPHeaders()
            }
            requestHeaders.add(name: "Authorization", value: String(format: "Client-ID %@", arguments: [Constants.unsplash.AccessKey]))
            
            AF.request(url, method: method, parameters: parameters, headers: requestHeaders,
                       requestModifier: { $0.timeoutInterval = ServiceManager.REQUEST_TIMEOUT })
                .validate()
                .validate(contentType: ["application/json"])
                .response { response in
                    switch response.result {
                    case .success:
                        if let responseData = response.data {
                            successBlock(responseData)
                        } else {
                            errorBlock(Constants.Messages.commonErrorMessage)
                        }
                        print("Validation Successful")
                    case let .failure(error):
                        print("API call failed : \(error)")
                        errorBlock(error.localizedDescription)
                    }
                }
        } else {
            errorBlock(Constants.Messages.networkErrorMessage)
        }
        
    }
    
    // MARK: - Private - Reachability
    private func monitorReachability() {
        reachability.startListening { status in
            print("Reachability Status Changed: \(status)")
        }
    }
}
