//
//  BookListPresenter.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import Foundation

class BookListPresenter: Presenter, BookListPresenterProtocol {
    @Published var viewModel =  BookListViewModel(searchedBookList: [], searchedText: "")
    private var books: [VolumeModel] = []
    private var interactor: BookListInteractorProtocol
    
    init(interactor: BookListInteractorProtocol) {
        self.interactor = interactor
    }
    
    func search() {
        let text = viewModel.searchedText.lowercased()
        viewModel.loading = true
        interactor.search(with: text) { [weak self] response in
            self?.viewModel.loading = false
            switch response {
            case .success(let items):
                self?.books = items
                let volumes = items.compactMap { volume in
                    BookListViewModel.Item(id: volume.id, text: volume.volumeInfo.title)
                }
                self?.viewModel.searchedBookList = volumes
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDetailViewModel(with bookID: String) -> BookDetailViewModel {
        if let book = books.first(where: { $0.id == bookID }) {
            let authors = book.volumeInfo.authors?.joined(separator: ", ") ?? ""
            let date = book.volumeInfo.publishedDate?.formatDate(formatReturn: "dd/MM/yyyy") ?? ""
            let isbnArray = book.volumeInfo.industryIdentifiers?.compactMap({ $0.identifier }) ?? []
            let isbn = isbnArray.joined(separator: ", ")
            let pages: String = String(book.volumeInfo.pageCount ?? 0)
            return .init(title: book.volumeInfo.title,
                         author: authors,
                         rating: book.volumeInfo.averageRating ?? 0,
                         image: .init(string: book.volumeInfo.imageLinks?.thumbnail ?? "") ?? URL(fileURLWithPath: ""),
                         items: [
                            .init(title: "Descripción:",
                                  value: book.volumeInfo.volumeDescription ?? "",
                                  double: true),
                            .init(title: "Editorial:", value: book.volumeInfo.publisher ?? ""),
                            .init(title: "Publicación:", value: date),
                            .init(title: "ISBN:", value: isbn),
                            .init(title: "Nº páginas:", value: pages)
                         ])
        }
        return .init(title: "", author: "", rating: 0, image: .init(fileURLWithPath: ""), items: [])
    }
}
