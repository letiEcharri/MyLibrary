//
//  BookListDataSource.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

class BookListDataSource: GoogleProvider, BookListDataSourceProtocol {
    
    func search(with text: String, completion: @escaping BookListCompletionBlock) {
        guard var components = URLComponents(string: self.urlBase) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "URL not valid"]) as Error
            completion(.failure(error))
            return
        }
        components.path = GoogleDataSourceModule.volumes.path
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
        ]
        guard let url = components.url else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "URL not valid"]) as Error
            completion(.failure(error))
            return
        }
        
        manager.executeRequest(with: url,
                               httpMethod: .get,
                               httpBody: nil,
                               headers: nil)
        { response in
            switch response {
            case .success(let object):
                guard let data = object as? Data else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion(.failure(error))
                    return
                }
                
                if let volumes = try? JSONDecoder().decode(VolumesModel.self, from: data) {
                    completion(.success(volumes))

                } else if let error = try? JSONDecoder().decode(GoogleErrorModel.self, from: data) {
                    let text = "\(error.error.code): \(error.error.message)"
                    let nserror = NSError(domain: error.error.errors.first?.domain ?? "", code: error.error.code, userInfo: [NSLocalizedDescriptionKey : text]) as Error
                    completion(.failure(nserror))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error with data model"]) as Error
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
