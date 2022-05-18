//
//  BookListViewModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 18/5/22.
//

import SwiftUI

protocol BookListViewModel: ObservableObject {
    var books: [Book] { get }
    var searchedText: String { get set }
    func search() async
}

class BookListViewModelImpl: BookListViewModel {
    var searchBooksUseCase = SearchBooksUseCase(repository: BookRepositoryImpl(dataSource: BookAPIImpl()))
    @Published var books: [Book] = []
    @Published var searchedText = ""
    
    func search() async {        
        let result = await searchBooksUseCase.search(with: searchedText)
        switch result {
        case .success(let books):
            DispatchQueue.main.async {
                self.books = books
            }
        case .failure:
            books = []
        }
    }
}
