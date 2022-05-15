//
//  BookDetailView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import SwiftUI

struct BookDetailView<T: BookDetailPresenterProtocol>: View {
    @ObservedObject var presenter: T
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            AsyncImage(url: presenter.viewModel.image) { image in
                image
                .resizable()
                .frame(width: 150, height: 200)
                .cornerRadius(10)
                .shadow(color: Color.gray, radius: 5, x: 2, y: 2)
            } placeholder: {
                ProgressView()
            }
            Text(presenter.viewModel.title)
                .font(.system(size: 20).bold())
            Text(presenter.viewModel.author)
                .font(.system(size: 16))
            RatingView(rating: $presenter.viewModel.rating)

            List {
                Section {
                    ForEach(presenter.viewModel.items, id: \.self) { item in
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
        let filePath = Bundle.main.path(forResource: "harryPotter", ofType: "jpeg")!
        let viewModel = BookDetailViewModel(title: "Harry Potter y el misterio del principe",
                                            author: "J. K. Rowling",
                                            rating: 2.5,
                                            image: URL(fileURLWithPath: filePath),
                                            items: [
                                                .init(title: "Descripción:",
                                                      value: "Harry Potter y el misterio del príncipe es la sexta novela de la ya clásica serie fantástica de la autora británica J.K. Rowling",
                                                      double: true),
                                                .init(title: "Editorial:", value: "Salamandra Infantil Y Juvenil"),
                                                .init(title: "Publicación:", value: "2021-08-24"),
                                                .init(title: "ISBN:", value: "6073193955, 9786073193955"),
                                                .init(title: "Nº páginas:", value: "608")
                                            ])
        
        BookDetailFactory.make(with: viewModel)
    }
}
