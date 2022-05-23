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
    @State var searchType: SearchFiltersItem.ItemType = .all
    @State var orderBy: SearchFiltersItem.Sort = .relevance
        
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
    
    var orderByView: some View {
        VStack(alignment: .leading) {
            Text("Ordenar por:")
                .font(.system(size: 18).italic())
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("", selection: $orderBy) {
                ForEach(SearchFiltersItem.Sort.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .onChange(of: orderBy, perform: { newValue in
                viewModel.filter.orderBy.wrappedValue = newValue
            })
            .pickerStyle(MenuPickerStyle())
            
        }
    }
    
    var searchButton: some View {
        HStack(alignment: .center) {
            Spacer()
            Button {
                viewModel.filter.searchActive.wrappedValue = true
                presentation.wrappedValue.dismiss()
            } label: {
                Text("BUSCAR")
                    .font(.system(size: 18, weight: .bold))
                 .foregroundColor(.white)
                 .frame(width: 100, height: 50, alignment: .center)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
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
                    orderByView
                    searchButton
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
            searchType = viewModel.filter.itemType.wrappedValue
            orderBy = viewModel.filter.orderBy.wrappedValue
        })
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
    var orderBy: Sort = .relevance
    var searchActive: Bool = false
    
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
    
    enum Sort: String, CaseIterable, Identifiable {
        case relevance = "Relevancia"
        case newest = "Novedad"
        
        var id: String { self.rawValue }
    }
}

extension Factory {
    internal func makeSearchFiltersView(with viewModel: SearchFiltersViewModelImpl) -> some View {
        SearchFiltersView(viewModel: viewModel).modifier(NavigationBarModifier())
    }
}
