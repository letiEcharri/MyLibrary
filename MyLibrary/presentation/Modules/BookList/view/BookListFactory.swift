//
//  BookListFactory.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import SwiftUI

enum BookListFactory {
    static func make() -> some View {
        let presenter = BookListPresenter()
        let view = BookListContentView(presenter: presenter)
        return view
    }
}
