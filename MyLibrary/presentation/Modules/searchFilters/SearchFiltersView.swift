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
        
    var searchBy: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach($viewModel.filterItems, id: \.self) { $item in
                    Button {
                        item.active.toggle()
                        searchByButtonAction(item)
                    } label: {
                        Text(item.title.rawValue)
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
            onDismiss?(viewModel.filter)
        }
    }
    
    private func searchByButtonAction(_ item: SearchFiltersItem) {
        viewModel.filter.wrappedValue = item.active ? item.title : .none
        for filter in $viewModel.filterItems {
            if filter.title.wrappedValue != item.title {
                filter.wrappedValue.active = false
            }
        }
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        Factory.searchFilters(viewModel: .init(.constant(.title))).make()
    }
}

enum Filter: String {
    case none
    case title = "Título"
    case author = "Autor"
    case category = "Categoría"
    case isbn = "ISBN"
}

struct SearchFiltersItem: Hashable {
    var title: Filter
    var active: Bool
}

extension Factory {
    internal func makeSearchFiltersView(with viewModel: SearchFiltersViewModelImpl) -> some View {
        SearchFiltersView(viewModel: viewModel).modifier(NavigationBarModifier())
    }
}
