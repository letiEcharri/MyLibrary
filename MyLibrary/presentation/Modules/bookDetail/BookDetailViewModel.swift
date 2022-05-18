//
//  BookDetailViewModel.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 18/5/22.
//

import Foundation

protocol BookDetailViewModel: ObservableObject {
    var book: BookDetailModel { get set }
}

class BookDetailViewModelImpl: BookDetailViewModel {
    @Published var book: BookDetailModel
    
    init(book: Book) {
        let authors = book.authors?.joined(separator: ", ") ?? ""
        let date = book.publishedDate?.formatDate(formatReturn: "dd/MM/yyyy") ?? ""
        let isbnArray = book.industryIdentifiers?.compactMap({ $0.identifier }) ?? []
        let isbn = isbnArray.joined(separator: ", ")
        let pages: String = String(book.pageCount ?? 0)
        self.book = .init(title: book.title,
                          author: authors,
                          rating: book.averageRating ?? 0,
                          image: .init(string: book.imageLinks?.thumbnail ?? "") ?? URL(fileURLWithPath: ""),
                          items: [
                            .init(title: "Descripción:",
                                  value: book.volumeDescription ?? "",
                                  double: true),
                            .init(title: "Editorial:", value: book.publisher ?? ""),
                            .init(title: "Publicación:", value: date),
                            .init(title: "ISBN:", value: isbn),
                            .init(title: "Nº páginas:", value: pages)
                          ])
    }
}
