//
//  BookDetailView.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 14/5/22.
//

import SwiftUI

struct BookDetailView: View {
    
    init() {
        setBlueNavigationView()
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Spacer()
                Image("harryPotter")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
                Text("Harry Potter y el misterio del principe")
                    .font(.system(size: 20).bold())
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.yellow)
                    Text("5")
                }
                List {
                    Section {
                        ForEach((1...10), id: \.self) { _ in
                            HStack(alignment: .top) {
                                Text("Autor/es:")
                                    .font(.system(size: 16).italic())
                                Text("J.K. Rowling")
                                    .font(.system(size: 16))
                            }
                        }
                    }
                }
                Spacer()
            }
            .background(Color.backgroundGrey)
            .navigationTitle("Detalle")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailFactory.make()
    }
}
