//
//  SearchFiltersView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/5/22.
//

import SwiftUI

struct SearchFiltersView<MT: SearchFiltersViewModel>: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: MT
    var onDismiss: ((_ model: Binding<Filter>) -> Void)?
    
    @State var filterItems: [SearchFiltersItem] = []
    
    var searchBy: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach($filterItems, id: \.self) { $item in
                    Button {
                        item.active.toggle()
                        searchByButtonAction(item)
                    } label: {
                        Text(item.title)
                         .font(.system(size: 18))
                         .foregroundColor(item.active ? .white : .black)
                         .frame(width: 100, height: 50, alignment: .center)
                         .overlay(
                             RoundedRectangle(cornerRadius: 10)
                                 .stroke(Color.blue, lineWidth: 2)
                         )
                         .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(item.active ? Color.blue : Color.clear)
                         )
                    }
                }
            }
            .padding(2)
        }
        .padding()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Búsqueda por:")
                    .font(.system(size: 18).italic())
                    .frame(maxWidth: .infinity, alignment: .leading)
                searchBy
                Spacer()
            }
            .padding()
            .navigationBarTitle("FILTROS", displayMode: .inline)
        }
        .onAppear(perform: {
            filterItems = getFilters()
        })
        .onDisappear {
            onDismiss?(viewModel.filter)
        }
    }
    
    private func searchByButtonAction(_ item: SearchFiltersItem) {
        switch item.title {
        case "Título":
            viewModel.filter.wrappedValue = .title
        case "Autor":
            viewModel.filter.wrappedValue = .author
        case "Categoría":
            viewModel.filter.wrappedValue = .category
        case "ISBN":
            viewModel.filter.wrappedValue = .isbn
        default:
            viewModel.filter.wrappedValue = .none
        }
    }
    
    private func getFilters() -> [SearchFiltersItem] {
        return [
            .init(title: "Título", active: viewModel.filter.wrappedValue == .title),
            .init(title: "Autor", active: viewModel.filter.wrappedValue == .author),
            .init(title: "Categoría", active: viewModel.filter.wrappedValue == .category),
            .init(title: "ISBN", active: viewModel.filter.wrappedValue == .isbn)
        ]
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        Factory.searchFilters(viewModel: .init(.constant(.title))).make()
    }
}

enum Filter {
    case none
    case title
    case author
    case category
    case isbn
}

struct SearchFiltersItem: Hashable {
    var title: String
    var active: Bool
}

extension Factory {
    internal func makeSearchFiltersView(with viewModel: SearchFiltersViewModelImpl) -> some View {
        SearchFiltersView(viewModel: viewModel).modifier(NavigationBarModifier())
    }
}
