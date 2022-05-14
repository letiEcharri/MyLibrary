//
//  BaseProvider.swift
//  bookdesks-ios
//
//  Created by Leticia Echarri on 22/4/22.
//

import Foundation

class BaseProvider: NSObject, DataSource {
    
    func executeRequest(with url: URL, httpMethod: DataSourceMethod, httpBody: Data?, headers: [String : String]?, completion: @escaping CompletionBlock) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 20.0
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, responseURL, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    completion(.failure(error))
                } else if let jsonData = responseData {
                    completion(.success(jsonData as AnyObject))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
}
