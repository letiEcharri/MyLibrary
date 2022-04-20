//
//  BookListPresenter.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import Foundation

class BookListPresenter: BookListPresenterProtocol {
    @Published var viewModel =  BookListViewModel(books: [], searchedBookList: [], searching: false, searchedText: "")
    
    init() {
        let books = ["Lord of the Rings", "Twilight", "1984", "Fifty shades of Grey", "Romeo & Juliet", "The Little Prince"]
        viewModel.books = books
    }
    
    func search() {
        let newBooks = viewModel.books.filter({ $0.lowercased().contains(viewModel.searchedText.lowercased()) })
        viewModel.searchedBookList = newBooks
    }
}
