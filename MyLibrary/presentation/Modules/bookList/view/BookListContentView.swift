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
        
        LoadingView(isShowing: $presenter.viewModel.loading) {
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
                    }
                    
                    Section {
                        ForEach(presenter.viewModel.searchedBookList, id: \.self) { book in
                            NavigationLink(book.text) {
                                BookDetailFactory.make(with: self.presenter.getDetailViewModel(with: book.id))
                            }
                        }
                    }
                }
                .padding([.top], 0.5)
                .background(Color.backgroundGrey)
                .navigationBarTitle("MyLibrary", displayMode: .large)

            }
            .navigationViewStyle(.stack)
        }
    }
}

struct BookListContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookListFactory.make()
    }
}
