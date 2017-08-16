//
//  APIManager.swift
//  CollectionDemo
//
//  Created by Ganesh Potnuru on 8/7/17.
//  Copyright © 2017 Ganesh Potnuru. All rights reserved.
//

import Foundation

class APIManager {
    
    @discardableResult class func fetchInformation(withUrl urlString:String, params:JSON? = nil, succesResponse:((_ responseDict:JSON, _ statusCode: Int) -> ())? = nil, errorResponse:((_ error: NSError) -> ())? = nil) -> URLSessionDataTask? {
        
        guard let url = URL(string: urlString) else {
            errorResponse?(invalidUrlError)
            return nil
        }
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (responseData, urlResponse, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    errorResponse?(serverError)
                }
            }
            else {
                let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode ?? StatusCode.success.rawValue
                if let validData = responseData {
                    
                    do{
                        let jsonData = try JSONSerialization.jsonObject(with: validData, options: .allowFragments)
                        let json = JSON(jsonData)
                        DispatchQueue.main.async {
                            succesResponse?(json, statusCode)
                        }
                        
                    }
                    catch {
                        DispatchQueue.main.async {
                            errorResponse?(serverError)
                        }
                        
                    }
                }
            }
        })
        dataTask.resume()
        return dataTask
    }
}

extension APIManager {
    static var invalidUrlError: NSError {
        get {
            let error = NSError(domain: "com.dev.demo", code: StatusCode.inValidUrl.rawValue, userInfo: [NSLocalizedDescriptionKey: "URL is Invalid"])
            return error
        }
    }
    
    static var noInternetError: NSError {
        get {
            let error = NSError(domain: "com.dev.demo", code: StatusCode.noInternet.rawValue, userInfo: [NSLocalizedDescriptionKey: "Network is not available"])
            return error
        }
    }
    
    static var serverError: NSError {
        get {
            let error = NSError(domain: "com.dev.demo", code: StatusCode.noInternet.rawValue, userInfo: [NSLocalizedDescriptionKey: "Something wrong with server"])
            return error
        }
    }
}

enum StatusCode: Int {
    case inValidUrl = 400
    case noInternet = 500
    case success = 200
}

