//
//  BookDetailFactory.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import SwiftUI

enum BookDetailFactory {
    static func make() -> some View {
        let view = BookDetailView()
        return view
    }
}

struct BookDetailViewModel {
    let title: String
    let rating: String
    let items: [Item]
    
    struct Item {
        let title: String
        let value: String
        let double: Bool = false
    }
}
