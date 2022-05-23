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
    var orderBy: Sort = .relevance
    
    enum ItemType: String {
        case all
        case books
        case magazines
    }
    
    enum Sort: String {
        case relevance
        case newest
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
    
    mutating func setSort(with viewModel: SearchFiltersItem) {
        switch viewModel.orderBy {
        case .relevance:
            orderBy = .relevance
        case .newest:
            orderBy = .newest
        }
    }
}
