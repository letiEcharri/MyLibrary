//
//  BookDetailPresenterProtocol.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 15/5/22.
//

import Foundation

protocol BookDetailPresenterProtocol where Self: Presenter {
    var viewModel: BookDetailViewModel { get set }
}
