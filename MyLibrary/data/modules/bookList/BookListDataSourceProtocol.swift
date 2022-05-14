//
//  BookListDataSourceProtocol.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

typealias BookListCompletionBlock = (Result<VolumesModel>) -> Void

protocol BookListDataSourceProtocol {
    func search(with text: String, completion: @escaping BookListCompletionBlock)
}
