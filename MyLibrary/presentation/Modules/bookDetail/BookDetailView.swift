//
//  BookDetailView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import SwiftUI

struct BookDetailView<MT: BookDetailViewModel>: View {
    @ObservedObject var viewModel: MT
    
    var image: some View {
        AsyncImage(url: viewModel.book.image) { image in
            image
            .resizable()
            .frame(width: 150, height: 200)
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 5, x: 2, y: 2)
        } placeholder: {
            ProgressView()
        }
    }
    
    var table: some View {
        List {
            Section {
                ForEach(viewModel.book.items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        if item.double {
                            Text(item.title)
                                .font(.system(size: 16).bold())
                            Text(item.value)
                                .font(.system(size: 16))
                        } else {
                            HStack(alignment: .top) {
                                Text(item.title)
                                    .font(.system(size: 16).italic())
                                Text(item.value)
                                    .font(.system(size: 16))
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            image
            Text(viewModel.book.title)
                .font(.system(size: 20).bold())
            Text(viewModel.book.author)
                .font(.system(size: 16))
            RatingView(rating: $viewModel.book.rating)

            table
            Spacer()
        }
        .background(Color.backgroundGrey)
        .navigationBarTitle("Detalle", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().bounces = false
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let filePath = Bundle.main.path(forResource: "harryPotter", ofType: "jpeg")
        let urlImage = URL(fileURLWithPath: filePath!)
        Factory.detail(viewModel: .init(book: .init(title: "Harry Potter y el misterio del principe",
                                                    authors: ["J. K. Rowling"],
                                                    publisher: "Salamandra Infantil Y Juvenil",
                                                    publishedDate: "24/05/1984",
                                                    volumeDescription: "Harry Potter y el misterio del príncipe es la sexta novela de la ya clásica serie fantástica de la autora británica J.K. Rowling",
                                                    industryIdentifiers: [
                                                        BookIndustryIdentifiers(type: "", identifier: "6073193955"),
                                                        BookIndustryIdentifiers(type: "", identifier: "9786073193955")
                                                    ],
                                                    readingModes: nil,
                                                    pageCount: 608,
                                                    printType: nil,
                                                    categories: nil,
                                                    averageRating: 2.5,
                                                    contentVersion: nil,
                                                    imageLinks: .init(smallThumbnail: nil, thumbnail: urlImage.absoluteString),
                                                    language: nil,
                                                    previewLink: nil,
                                                    infoLink: nil,
                                                    canonicalVolumeLink: nil)))
            .make()
    }
}


struct BookDetailModel: Hashable {
    let title: String
    let author: String
    var rating: Double
    let image: URL
    let items: [Item]
    
    struct Item: Hashable {
        let title: String
        let value: String
        var double: Bool = false
    }
}

extension Factory {
    internal func makeBookDetailView(with viewModel: BookDetailViewModelImpl) -> some View {
        BookDetailView(viewModel: viewModel)
    }
}
