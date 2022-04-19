//
//  BookListContentView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import SwiftUI

struct BookListContentView<T: BookListPresenterProtocol>: View {
    @ObservedObject var presenter: T
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searching: $presenter.viewModel.searching, mainList: $presenter.viewModel.books, searchedList: $presenter.viewModel.searchedBookList)
                    .navigationTitle("MyLibrary")
                List(presenter.viewModel.searchedBookList, id: \.self) { book in
                    Text(book)
                }
            }
        }
    }
}

struct BookListContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookListFactory.make()
    }
}

struct BookListViewModel {
    var books: [String]
    var searchedBookList = [String]()
    var searching = false
}
