//
//  RootTabView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// RootTabView.swift
// TabView inferiore con 3 icone: Path, Dictionary, Flashcards
import SwiftUI

// Colori globali (usati in tutte le view)
fileprivate let backgroundColor = Color(hex: "F8E5D5")
fileprivate let titleColor = Color(hex: "0095B6")
fileprivate let subtitleColor = Color(hex: "124E7E")

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                PathView()
            }
            .tabItem {
                Image(systemName: "point.topright.filled.arrow.triangle.backward.to.point.bottomleft.scurvepath")
                Text("Path")
            }
            
            NavigationStack {
                DictionaryListView()
            }
            .tabItem {
                Image(systemName: "character.book.closed")
                Text("Dictionary")
            }
            
            NavigationStack {
                FlashcardsView()
            }
            .tabItem {
                Image(systemName: "pencil.and.list.clipboard")
                Text("Flashcards")
            }
        }
        .accentColor(titleColor)
        .background(backgroundColor.ignoresSafeArea())
    }
}

