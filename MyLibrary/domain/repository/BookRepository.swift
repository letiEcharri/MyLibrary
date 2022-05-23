//
//  BookRepository.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 17/5/22.
//

import Foundation

protocol BookRepository {
    func search(with text: String, filters: SearchFiltersModel) async throws -> [Book]
}

struct BookRepositoryImpl: BookRepository {
    var dataSource: BookDataSource
    
    func search(with text: String, filters: SearchFiltersModel) async throws -> [Book] {
        let _books = try await dataSource.search(with: text, filters: filters)
        return _books
    }
}
