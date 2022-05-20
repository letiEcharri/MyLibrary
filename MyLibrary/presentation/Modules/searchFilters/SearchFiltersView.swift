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
    var onDismiss: ((_ model: Binding<SearchFiltersItem>) -> Void)?
    @State var searchType: SearchFiltersItem.ItemType = .all
        
    var searchBy: some View {
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

    var searchTypeView: some View {
        VStack(alignment: .leading) {
            Text("Tipo de búsqueda:")
                .font(.system(size: 18).italic())
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("", selection: $searchType) {
                ForEach(SearchFiltersItem.ItemType.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .onChange(of: searchType, perform: { newValue in
                viewModel.filter.itemType.wrappedValue = newValue
            })
            .pickerStyle(SegmentedPickerStyle())
            
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Búsqueda por:")
                        .font(.system(size: 18).italic())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    searchBy
                    searchTypeView
                }
            }
            .padding()
            .navigationBarTitle("FILTROS", displayMode: .inline)
        }
        .onAppear(perform: {
            let blue = Color.blue.components
            let uiBlue = UIColor(red: blue.red, green: blue.green, blue: blue.blue, alpha: 1)
            UISegmentedControl.appearance().selectedSegmentTintColor = uiBlue
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: uiBlue], for: .normal)
        })
        .onDisappear {
            onDismiss?(viewModel.filter)
        }
    }
    
    private func searchByButtonAction(_ item: SearchFiltersItem.MainFilter) {
        viewModel.filter.mainFilter.title.wrappedValue = item.active ? item.title : .none
        for filter in $viewModel.filterItems {
            if filter.title.wrappedValue != item.title {
                filter.wrappedValue.active = false
            }
        }
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        Factory.searchFilters(viewModel: .init(.constant(.init(mainFilter: .init(title: .title,
                                                                                 active: true)))))
            .make()
    }
}

struct SearchFiltersItem: Hashable {
    var mainFilter: MainFilter
    var itemType: ItemType = .all
    
    struct MainFilter: Hashable {
        var title: Filter = .none
        var active: Bool = false
    }
    
    enum Filter: String {
        case none
        case title = "Título"
        case author = "Autor"
        case category = "Categoría"
        case isbn = "ISBN"
    }
    
    enum ItemType: String, CaseIterable, Identifiable {
        case all = "Todos"
        case books = "Libros"
        case magazines = "Revistas"
        
        var id: String { self.rawValue }
    }
}

extension Factory {
    internal func makeSearchFiltersView(with viewModel: SearchFiltersViewModelImpl) -> some View {
        SearchFiltersView(viewModel: viewModel).modifier(NavigationBarModifier())
    }
}
