//
//  Book.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 17/5/22.
//

import Foundation

struct Book: Hashable {
    let title: String
    let authors: [String]?
    let publisher, publishedDate, volumeDescription: String?
    let industryIdentifiers: [BookIndustryIdentifiers]?
    let readingModes: BookReadingModes?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let averageRating: Double?
    let contentVersion: String?
    let imageLinks: BookImageLinks?
    let language: String?
    let previewLink, infoLink: String?
    let canonicalVolumeLink: String?

    enum CodingKeys: String, CodingKey {
        case title, authors, publisher, publishedDate
        case volumeDescription = "description"
        case industryIdentifiers, readingModes, pageCount, printType, categories, averageRating, contentVersion, imageLinks, language, previewLink, infoLink, canonicalVolumeLink
    }
}

struct BookImageLinks: Hashable {
    let smallThumbnail, thumbnail: String?
}

struct BookIndustryIdentifiers: Hashable {
    let type, identifier: String
}

struct BookReadingModes: Hashable {
    let text, image: Bool
}
