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
                HStack {
                    TextField("Search results for books, authors, and more",
                              text: $presenter.viewModel.searchedText)
                        .accentColor(.black)
                        .foregroundColor(.black)
                        .onSubmit {
                            self.presenter.search()
                        }
                }
                .frame(height: 50)
                List(presenter.viewModel.searchedBookList, id: \.self) { book in
                    Text(book)
                }
            }
            .navigationTitle("MyLibrary")
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
    var searchedText: String
}
