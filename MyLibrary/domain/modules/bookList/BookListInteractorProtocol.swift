//
//  BookListInteractorProtocol.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

typealias BookListItemsCompletionBlock = (Result<[VolumeModel]>) -> Void

protocol BookListInteractorProtocol {
    func search(with text: String, completion: @escaping BookListItemsCompletionBlock)
}
