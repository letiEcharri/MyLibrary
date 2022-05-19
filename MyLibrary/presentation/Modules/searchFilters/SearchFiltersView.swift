//
//  SearchFiltersView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/5/22.
//

import SwiftUI

struct SearchFiltersView: View {
    @Environment(\.presentationMode) var presentation
    var onDismiss: ((_ model: Filter) -> Void)?
    @Binding var filter: Filter
    
    @State var filterItems: [SearchFiltersItem] = [
        .init(title: "Título", active: false),
        .init(title: "Autor", active: false),
        .init(title: "Categoría", active: false),
        .init(title: "ISBN", active: false)
    ]
    
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
        .onDisappear {
            onDismiss?(filter)
        }
    }
    
    private func searchByButtonAction(_ item: SearchFiltersItem) {
        switch item.title {
        case "Título":
            filter.searhBy = .title
        case "Autor":
            filter.searhBy = .author
        case "Categoría":
            filter.searhBy = .category
        case "ISBN":
            filter.searhBy = .isbn
        default:
            filter.searhBy = .none
        }
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    @State static var filter = Filter(searhBy: .none)
    
    static var previews: some View {
        Factory.searchFilters($filter).make()
    }
}

struct Filter {
    var searhBy: Search
    
    enum Search {
        case none
        case title
        case author
        case category
        case isbn
    }
}

struct SearchFiltersItem: Hashable {
    var title: String
    var active: Bool
}

extension Factory {
    internal func makeSearchFiltersView(_ filter: Binding<Filter>) -> some View {
        SearchFiltersView(filter: filter).modifier(NavigationBarModifier())
    }
}
