//
//  GoogleProvider.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

enum GoogleDataSourceModule: String {
    case volumes
    
    var path: String { "/books/v1/" + rawValue }
}

class GoogleProvider {
    
    var urlBase: String {
        "https://www.googleapis.com"
    }
    
    var manager: DataSource
        
    init(_ manager: DataSource) {
        self.manager = manager
    }
}
