//
//  BookListInteractor.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

class BookListInteractor: BookListInteractorProtocol {
    private var datasource: BookListDataSourceProtocol
    
    init(_ datasource: BookListDataSourceProtocol) {
        self.datasource = datasource
    }
    
    func search(with text: String, completion: @escaping BookListItemsCompletionBlock) {
        datasource.search(with: text) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let volumes):
                let cleanArray = self.removeDuplicateElements(volumes: volumes.items)
                completion(.success(cleanArray))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func removeDuplicateElements(volumes: [VolumeModel]) -> [VolumeModel] {
        var uniqueVolumes = [VolumeModel]()
        for volume in volumes {
            if !uniqueVolumes.contains(where: {$0.id == volume.id }) {
                uniqueVolumes.append(volume)
            }
        }
        return uniqueVolumes
    }
}
