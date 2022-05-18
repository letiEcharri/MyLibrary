//
//  GoogleProvider.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

struct GoogleProvider {
    enum Module: String {
        case volumes
        
        var path: String { "/books/v1/" + rawValue }
    }
    
    static var urlBase: String {
        "https://www.googleapis.com"
    }
}
