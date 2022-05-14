//
//  BookListPresenter.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import Foundation

class BookListPresenter: Presenter, BookListPresenterProtocol {
    @Published var viewModel =  BookListViewModel(searchedBookList: [], searchedText: "")
    
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
                let volumes = items.compactMap { volume in
                    BookListViewModel.Item(id: volume.id, text: volume.volumeInfo.title)
                }
                self?.viewModel.searchedBookList = volumes
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectItem(with id: String) {
        print("ID: \(id)")
    }
}
