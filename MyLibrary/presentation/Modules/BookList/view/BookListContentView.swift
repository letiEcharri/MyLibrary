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
            List {
                Section {
                    HStack {
                        TextField("Search for books, authors...",
                                  text: $presenter.viewModel.searchedText)
                            .frame(height: 50)
                            .accentColor(.black)
                            .foregroundColor(.black)
                            .onSubmit {
                                self.presenter.search()
                            }
                        Image(systemName: "magnifyingglass")
                    }
                    .navigationTitle("MyLibrary")
                }
                
                Section {
                    ForEach(presenter.viewModel.searchedBookList, id: \.self) { book in
                        Text(book)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
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
    var searchedText: String
}
