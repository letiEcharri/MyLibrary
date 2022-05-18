//
//  VolumesModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import Foundation

struct VolumesModel: Decodable {
    let kind: String
    let totalItems: Int?
    let items: [VolumeModel]
}

struct VolumeModel: Decodable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfoModel
}

struct VolumeInfoModel: Decodable {
    let title: String
    let authors: [String]?
    let publisher, publishedDate, volumeDescription: String?
    let industryIdentifiers: [IndustryIdentifierModel]?
    let readingModes: ReadingModesModel?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let averageRating: Double?
    let ratingsCount: Int?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummaryModel?
    let imageLinks: ImageLinksModel?
    let language: String?
    let previewLink, infoLink: String?
    let canonicalVolumeLink: String?

    enum CodingKeys: String, CodingKey {
        case title, authors, publisher, publishedDate
        case volumeDescription = "description"
        case industryIdentifiers, readingModes, pageCount, printType, categories, averageRating, ratingsCount, maturityRating, allowAnonLogging, contentVersion, panelizationSummary, imageLinks, language, previewLink, infoLink, canonicalVolumeLink
    }
}

struct ImageLinksModel: Decodable {
    let smallThumbnail, thumbnail: String?
}

struct IndustryIdentifierModel: Decodable {
    let type, identifier: String
}

struct PanelizationSummaryModel: Decodable {
    let containsEpubBubbles, containsImageBubbles: Bool
}

struct ReadingModesModel: Decodable {
    let text, image: Bool
}
