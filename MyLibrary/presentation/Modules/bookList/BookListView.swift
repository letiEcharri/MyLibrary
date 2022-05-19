//
//  BookListView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 18/5/22.
//

import SwiftUI

struct BookListView<MT: BookListViewModel>: View {
    @ObservedObject var viewModel: MT
    @State private var showFilters = false
    @State var filter = Filter(searhBy: .none)
    
    var searchBar: some View {
        HStack {
            TextField("Search for books, authors...",
                      text: $viewModel.searchedText)
                .frame(height: 50)
                .accentColor(.black)
                .foregroundColor(.black)
                .onSubmit {
                    print(filter)
                    self.search()
                }
            Button {
                self.showFilters = true
            } label: {
                Image(systemName: "slider.horizontal.3")
            }
        }
        .sheet(isPresented: $showFilters, content: {
            Factory.searchFilters($filter).make()
        })

    }
    
    var listRow: some View {
        ForEach(viewModel.books, id: \.self) { book in
            NavigationLink(book.title) {
                Factory.detail(viewModel: .init(book: book)).make()
            }
        }
    }
    
    var body: some View {
        LoadingView(isShowing: $viewModel.loading) {
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
