//
//  SearchBooksUseCase.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 18/5/22.
//

import Foundation

enum UseCaseError: Error{
    case networkError, decodingError
}

protocol SearchBooks {
    func search(with text: String, filters: SearchFiltersModel) async -> Result<[Book], UseCaseError>
}

struct SearchBooksUseCase: SearchBooks {
    var repository: BookRepository
    
    func search(with text: String, filters: SearchFiltersModel) async -> Result<[Book], UseCaseError> {
        do {
            let books = try await repository.search(with: text, filters: filters)
            return .success(books)
        } catch {
            switch error {
            case APIServiceError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
