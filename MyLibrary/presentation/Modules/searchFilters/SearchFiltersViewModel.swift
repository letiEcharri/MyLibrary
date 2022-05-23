//
//  SearchFiltersViewModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/5/22.
//

import SwiftUI

protocol SearchFiltersViewModel: ObservableObject {
    var filter: Binding<SearchFiltersItem> { get set }
    var filterItems: [SearchFiltersItem.MainFilter] { get set }
}

class SearchFiltersViewModelImpl: SearchFiltersViewModel {
    @Published var filter: Binding<SearchFiltersItem>
    @Published var filterItems: [SearchFiltersItem.MainFilter]
        
    init(_ filter: Binding<SearchFiltersItem>) {
        self.filter = filter
        filterItems = [
            .init(title: SearchFiltersItem.Filter.title, active: filter.mainFilter.title.wrappedValue == .title),
            .init(title: SearchFiltersItem.Filter.author, active: filter.mainFilter.title.wrappedValue == .author),
            .init(title: SearchFiltersItem.Filter.category, active: filter.mainFilter.title.wrappedValue == .category),
            .init(title: SearchFiltersItem.Filter.isbn, active: filter.mainFilter.title.wrappedValue == .isbn)
        ]
    }
}
