//
//  BookAPIImpl.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 17/5/22.
//

import Foundation

enum APIServiceError: Error {
    case badUrl, requestError, decodingError, statusNotOK
}

struct BookAPIImpl: BookDataSource {
    
    func search(with text: String) async throws -> [Book] {
        guard var components = URLComponents(string: GoogleProvider.urlBase) else {
            throw APIServiceError.badUrl
        }
        components.path = GoogleProvider.Module.volumes.path
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
        ]
        guard let url = components.url else {
            throw APIServiceError.badUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIServiceError.requestError
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.statusNotOK
        }

        guard let result = try? JSONDecoder().decode(VolumesModel.self, from: data) else {
            throw APIServiceError.decodingError
        }

        return result.items.map { item in
            Book(title: item.volumeInfo.title,
                 authors: item.volumeInfo.authors,
                 publisher: item.volumeInfo.publisher,
                 publishedDate: item.volumeInfo.publishedDate,
                 volumeDescription: item.volumeInfo.volumeDescription,
                 industryIdentifiers: item.volumeInfo.industryIdentifiers?.compactMap({ BookIndustryIdentifiers(type: $0.type ,identifier: $0.identifier) }),
                 readingModes: BookReadingModes(text: item.volumeInfo.readingModes?.text ?? false, image: item.volumeInfo.readingModes?.image ?? false),
                 pageCount: item.volumeInfo.pageCount,
                 printType: item.volumeInfo.printType,
                 categories: item.volumeInfo.categories,
                 averageRating: item.volumeInfo.averageRating,
                 contentVersion: item.volumeInfo.contentVersion,
                 imageLinks: BookImageLinks(smallThumbnail: item.volumeInfo.imageLinks?.smallThumbnail ?? "", thumbnail: item.volumeInfo.imageLinks?.thumbnail ?? ""),
                 language: item.volumeInfo.language,
                 previewLink: item.volumeInfo.previewLink,
                 infoLink: item.volumeInfo.infoLink,
                 canonicalVolumeLink: item.volumeInfo.canonicalVolumeLink)
        }
    }
}
