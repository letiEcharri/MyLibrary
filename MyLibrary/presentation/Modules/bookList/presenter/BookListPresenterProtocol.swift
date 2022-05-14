//
//  BookListPresenterProtocol.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import Foundation

protocol BookListPresenterProtocol where Self: Presenter {
    var viewModel: BookListViewModel { get set }
    
    func search()
    func selectItem(with id: String)
}
