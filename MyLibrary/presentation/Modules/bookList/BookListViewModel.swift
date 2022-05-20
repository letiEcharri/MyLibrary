//
//  BookListViewModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 18/5/22.
//

import Foundation

protocol BookListViewModel: ObservableObject {
    var books: [Book] { get }
    var searchedText: String { get set }
    var loading: Bool { get set }
    var filter: SearchFiltersItem { get set }
    func search() async
}

class BookListViewModelImpl: BookListViewModel {
    var searchBooksUseCase: SearchBooks = SearchBooksUseCase(repository: BookRepositoryImpl(dataSource: BookAPIImpl()))
    @Published var books: [Book] = []
    @Published var searchedText = ""
    @Published var loading = false
    @Published var filter: SearchFiltersItem = .init(mainFilter: .init())
    
    func search() async {
        loading = true
        var viewFilters = SearchFiltersModel(mainFilter: filter.mainFilter.title, itemType: .all)
        viewFilters.setType(with: filter)
        let result = await searchBooksUseCase.search(with: searchedText, filters: viewFilters)
        switch result {
        case .success(let books):
            DispatchQueue.main.async {
                self.loading = false
                self.books = books
            }
        case .failure:
            DispatchQueue.main.async {
                self.loading = false
                self.books = []
            }
        }
    }
}
