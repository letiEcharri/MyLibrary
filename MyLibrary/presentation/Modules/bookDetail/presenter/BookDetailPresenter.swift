//
//  BookDetailPresenter.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 15/5/22.
//

import Foundation

class BookDetailPresenter: Presenter, BookDetailPresenterProtocol {
    @Published var viewModel: BookDetailViewModel
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
    }
}
