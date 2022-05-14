//
//  DataSource.swift
//  bookdesks-ios
//
//  Created by Leticia Echarri on 22/4/22.
//

import Foundation

typealias CompletionBlock = (Result<AnyObject>) -> Void
typealias BoolCompletionBlock = (Result<Bool>) -> Void

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

enum DataSourceMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol DataSource {
    func executeRequest(with url: URL, httpMethod: DataSourceMethod, httpBody: Data?, headers: [String: String]?, completion: @escaping CompletionBlock)
}
