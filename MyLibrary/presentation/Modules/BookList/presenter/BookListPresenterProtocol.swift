//
//  BookListPresenterProtocol.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import Foundation

protocol BookListPresenterProtocol: ObservableObject {
    var viewModel: BookListViewModel { get set }
    
    func search()
}
