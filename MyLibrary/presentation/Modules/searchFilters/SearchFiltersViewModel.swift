//
//  SearchFiltersViewModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/5/22.
//

import SwiftUI

protocol SearchFiltersViewModel: ObservableObject {
    var filter: Binding<Filter> { get set }
    var filterItems: [SearchFiltersItem] { get set }
}

class SearchFiltersViewModelImpl: SearchFiltersViewModel {
    @Published var filter: Binding<Filter>
    @Published var filterItems: [SearchFiltersItem]
        
    init(_ filter: Binding<Filter>) {
        self.filter = filter
        filterItems = [
            .init(title: Filter.title, active: filter.wrappedValue == .title),
            .init(title: Filter.author, active: filter.wrappedValue == .author),
            .init(title: Filter.category, active: filter.wrappedValue == .category),
            .init(title: Filter.isbn, active: filter.wrappedValue == .isbn)
        ]
    }
}
