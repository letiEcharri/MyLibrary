//
//  SearchFiltersModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 20/5/22.
//

import Foundation

struct SearchFiltersModel {
    var mainFilter: SearchFiltersItem.Filter
    var itemType: ItemType = .all
    
    enum ItemType: String {
        case all
        case books
        case magazines
    }
    
    mutating func setType(with viewModel: SearchFiltersItem) {
        switch viewModel.itemType {
        case .all:
            itemType = .all
        case .books:
            itemType = .books
        case .magazines:
            itemType = .magazines
        }
    }
}
