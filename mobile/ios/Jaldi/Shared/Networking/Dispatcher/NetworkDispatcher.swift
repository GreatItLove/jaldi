//
//  NetworkDispatcher.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/18/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import Alamofire

public enum NetworkErrors: Error {
    case badInput
    case noData
    case networkMessage(error_:String, message:String)
}
public class NetworkDispatcher: Dispatcher {
    static func defaultDispatcher() -> NetworkDispatcher{
      return NetworkDispatcher(environment: Environment.defaultEnvironment())
    }
    private var environment: Environment
    private var session: URLSession
    required public init(environment: Environment) {
        self.environment = environment
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
   public func execute(request: JaldiRequest, completion: @escaping ((_ result:JaldiResponse)->Void)){
        let rq =  self.prepareURLRequest(for: request)
        rq.responseJSON { response in
            print(response)
            let jaldiResponse  = JaldiResponse((isSuccess: response.result.isSuccess, value: response.result.value as AnyObject?, r: response.response, data: response.data, error: response.error), for: request)
            completion(jaldiResponse)
        }
    }

    private func prepareURLRequest(for request: JaldiRequest) -> DataRequest {
        // Compose the url
        let path = "\(environment.host)/\(request.path)"
        var headers: [String: String] = [:]
        var bodyParams: [String: Any]? = [:]
        
        // Working with parameters
        switch request.parameters {
        case .body(let params):
            // Parameters are part of the body
            bodyParams = params
        case .url(let params):
            print(params ?? "")
            // Parameters are part of the url
            //TODO: implemenet url
        }
        // Add headers from enviornment and request
        environment.headers.forEach { headers[$0.key] = $0.value}
        request.headers?.forEach { headers[$0.key] = $0.value }
        
  
       let dateRequest =  Alamofire.request(path, method: request.method, parameters: bodyParams, encoding: JSONEncoding.default, headers: headers)
        print("path \(path)")
        print("headers \(headers)")
        print("bodyParams \(bodyParams)")
        return dateRequest
    }
}


//    public func execute(request: JaldiRequest) throws -> Void {
//        let rq = try self.prepareURLRequest(for: request)
//        let d = self.session.dataTask(with: rq, completionHandler: { (data, urlResponse, error) in
//            let hhtpResponce  = urlResponse as! HTTPURLResponse
//                           print(hhtpResponce.allHeaderFields)
//            let datastring  = String(bytes: data!, encoding: String.Encoding.utf8)
////            let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                    print("response.data ---  \(datastring)")
//                        })
//        d.resume()
//    }
//    private func prepareURLRequest(for request: JaldiRequest) throws -> URLRequest {
//        // Compose the url
//        let full_url = "\(environment.host)/\(request.path)"
//        var url_request = URLRequest(url: URL(string: full_url)!)
//
//        // Working with parameters
//        switch request.parameters {
//        case .body(let params):
//            // Parameters are part of the body
//            if let params = params as? [String: String] { // just to simplify
//                url_request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .init(rawValue: 0))
//            } else {
//                throw NetworkErrors.badInput
//            }
//        case .url(let params):
//            // Parameters are part of the url
//            if let params = params as? [String: String] { // just to simplify
//                let query_params = params.map({ (element) -> URLQueryItem in
//                    return URLQueryItem(name: element.key, value: element.value)
//                })
//                guard var components = URLComponents(string: full_url) else {
//                    throw NetworkErrors.badInput
//                }
//                components.queryItems = query_params
//                url_request.url = components.url
//            } else {
//                throw NetworkErrors.badInput
//            }
//        }
//
//        // Add headers from enviornment and request
//        environment.headers.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
//        request.headers?.forEach { url_request.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
//
//        // Setup HTTP method
//        url_request.httpMethod = request.method.rawValue
//
//        return url_request
//    }
