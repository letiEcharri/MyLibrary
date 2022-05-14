//
//  MyLibraryApp.swift
//  MyLibrary
//
//  Created by Leticia Echarri on 19/4/22.
//

import SwiftUI

@main
struct MyLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            BookListFactory.make()
        }
    }
}
