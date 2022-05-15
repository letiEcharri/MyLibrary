//
//  BookDetailFactory.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import SwiftUI

enum BookDetailFactory {
    static func make(with viewModel: BookDetailViewModel) -> some View {
        let presenter = BookDetailPresenter(viewModel: viewModel)
        let view = BookDetailView(presenter: presenter)
        return view
    }
}

struct BookDetailViewModel: Hashable {
    let title: String
    let author: String
    var rating: Double
    let image: URL
    let items: [Item]
    
    struct Item: Hashable{
        let title: String
        let value: String
        var double: Bool = false
    }
}
