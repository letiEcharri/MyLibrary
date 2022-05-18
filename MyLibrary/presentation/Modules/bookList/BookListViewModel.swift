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
    var loading: Bool { get set }
    func search() async
}

class BookListViewModelImpl: BookListViewModel {
    var searchBooksUseCase = SearchBooksUseCase(repository: BookRepositoryImpl(dataSource: BookAPIImpl()))
    @Published var books: [Book] = []
    @Published var searchedText = ""
    @Published var loading = false
    
    func search() async {
        loading = true
        let result = await searchBooksUseCase.search(with: searchedText)
        switch result {
        case .success(let books):
            DispatchQueue.main.async {
                self.loading = false
                self.books = books
            }
        case .failure:
            books = []
        }
    }
}
