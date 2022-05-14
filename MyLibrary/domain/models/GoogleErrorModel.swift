//
//  GoogleErrorModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

struct GoogleErrorModel: Codable {
    let error: GoogleErrorErrorModel
}

struct GoogleErrorErrorModel: Codable {
    let code: Int
    let message: String
    let errors: [ErrorElementModel]
}

struct ErrorElementModel: Codable {
    let message, domain, reason: String
}
