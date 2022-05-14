//
//  BookListFactory.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import SwiftUI

enum BookListFactory {
    static func make() -> some View {
        let datasource = BookListDataSource(BaseProvider())
        let interactor = BookListInteractor(datasource)
        let presenter = BookListPresenter(interactor: interactor)
        let view = BookListContentView(presenter: presenter)
        return view
    }
}

struct BookListViewModel: Hashable {
    var searchedBookList: [Item]
    var searchedText: String
    var loading = false
    
    struct Item: Hashable {
        let id: String
        let text: String
    }
}
