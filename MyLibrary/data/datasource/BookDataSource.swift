//
//  BookDataSource.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 17/5/22.
//

import Foundation

protocol BookDataSource {
    func search(with text: String) async throws -> [Book]
}
