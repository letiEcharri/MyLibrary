//
//  Factory.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 18/5/22.
//

import SwiftUI

enum Factory {
    case list
    case detail(viewModel: BookDetailViewModelImpl)
    
    @ViewBuilder
    func make() -> some View {
        switch self {
        case .list:
            makeBookListView()
        case .detail(let viewModel):
            makeBookDetailView(with: viewModel)
        }
    }
}
