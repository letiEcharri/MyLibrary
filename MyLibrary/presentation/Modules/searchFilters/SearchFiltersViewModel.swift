//
//  SearchFiltersViewModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/5/22.
//

import SwiftUI

protocol SearchFiltersViewModel: ObservableObject {
    var filter: Binding<Filter> { get set }
}

class SearchFiltersViewModelImpl: SearchFiltersViewModel {
    @Published var filter: Binding<Filter>
        
    init(_ filter: Binding<Filter>) {
        self.filter = filter
    }
}
