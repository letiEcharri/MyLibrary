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
    case searchFilters(_ filter: Binding<Filter>)
    
    @ViewBuilder
    func make() -> some View {
        switch self {
        case .list:
            makeBookListView()
        case .detail(let viewModel):
            makeBookDetailView(with: viewModel)
        case .searchFilters(let filter):
            makeSearchFiltersView(filter)
        }
    }
}
