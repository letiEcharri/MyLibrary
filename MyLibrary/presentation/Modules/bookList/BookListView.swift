//
//  BookListView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 18/5/22.
//

import SwiftUI

struct BookListView<MT: BookListViewModel>: View {
    @ObservedObject var viewModel: MT
    
    var searchBar: some View {
        HStack {
            TextField("Search for books, authors...",
                      text: $viewModel.searchedText)
                .frame(height: 50)
                .accentColor(.black)
                .foregroundColor(.black)
                .onSubmit {
                    self.search()
                }
            Image(systemName: "magnifyingglass")
        }
    }
    
    var listRow: some View {
        ForEach(viewModel.books, id: \.self) { book in
            NavigationLink(book.title) {
                Factory.detail(viewModel: .init(book: book)).make()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
            List {
                Section {
                    searchBar
                }
                
                Section {
                    listRow
                }
            }
            .padding([.top], 0.5)
            .background(Color.backgroundGrey)
            .navigationBarTitle("MyLibrary", displayMode: .large)

        }
        .navigationViewStyle(.stack)
    }
    
    func search() {
        Task {
            await viewModel.search()
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(viewModel: BookListViewModelImpl()).modifier(NavigationBarModifier())
    }
}

extension Factory {
    internal func makeBookListView() -> some View {
        BookListView(viewModel: BookListViewModelImpl()).modifier(NavigationBarModifier())
    }
}
