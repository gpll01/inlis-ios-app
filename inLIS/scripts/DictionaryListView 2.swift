//
//  DictionaryListView.swift
//  InLIS2
//
//  Created by Ilenia Maiorano on 17/10/25.
//

import SwiftUI

struct DictionaryListView: View {
    @State private var searchText = ""
    @State private var collapsed = false
    @State private var showingAlphabet = false
    
    // Example words (you can replace or expand)
    let home = ["Abitare", "Camera", "Casa", "Finestra", "Giardino"]
    let family = ["Bambino", "Figlio", "Mamma", "Moglie", "Nonno", "Padre", "Sorella", "Zio"]
    let school = ["Libro", "Leggere", "Professore", "Scrivere", "Scuola"]
    let job = ["Avvocato", "Capo", "Collega", "Dottore", "Giudice", "Lavorare", "Lavoro"]
    
    // Filtri per sezione (case-insensitive, accent-insensitive di base)
    private func filtered(_ words: [String]) -> [String] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return words }
        return words.filter { $0.range(of: query, options: [.caseInsensitive, .diacriticInsensitive]) != nil }
    }
    
    var body: some View {
        ScrollView {
            // Tracker per lo scroll, come in PathView
            GeometryReader { geo in
                Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .named("dictScroll")).minY)
            }
            .frame(height: 0)
            
            VStack(alignment: .leading, spacing: 20) {
                Spacer(minLength: -5)
                
                // Sezioni filtrate: mostro la sezione solo se ha risultati
                let homeF = filtered(home)
                if !homeF.isEmpty {
                    SectionView(title: "Home", words: homeF)
                }
                
                let familyF = filtered(family)
                if !familyF.isEmpty {
                    SectionView(title: "Family", words: familyF)
                }
                
                let schoolF = filtered(school)
                if !schoolF.isEmpty {
                    SectionView(title: "School", words: schoolF)
                }
                
                let jobF = filtered(job)
                if !jobF.isEmpty {
                    SectionView(title: "Job", words: jobF)
                }
                
                // Spazio extra in fondo per non coprire l’ultimo contenuto con la search bar fissa
                Spacer(minLength: 120)
            }
            .padding(.horizontal)
        }
        .coordinateSpace(name: "dictScroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            withAnimation(.easeInOut(duration: 0.15)) {
                collapsed = (value < -20)
            }
        }
        .navigationTitle(collapsed ? "dictionary" : "Dictionary")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAlphabet = true
                } label: {
                    Image(systemName: "a.circle")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .accessibilityLabel("Alphabet")
            }
        }
        .navigationDestination(isPresented: $showingAlphabet) {
            AlphabetView()
        }
        .scrollIndicators(.hidden)
        .background(Color(hex:"F8E5D5").ignoresSafeArea())// beige background
        // Search bar fissa sopra la Tab Bar
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.primary)
                TextField("Search", text: $searchText)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .foregroundStyle(.primary)
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .accessibilityLabel("Clear search")
                }
            }
            .padding(12)
            // Materiale stile Tab Bar (quasi trasparente)
            // Bordo molto leggero per definire il contorno sul beige
            .glassEffect()
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.25), lineWidth: 0.8)
            )
            // Ombra minima o nulla per un look “liquid”
            .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 80)
            .padding(.vertical, 8)
            .background(
                // Manteniamo la zona trasparente così si integra con la Tab Bar
                Color.clear
                    .ignoresSafeArea(edges: .bottom)
            )
        }
    }
}

#Preview {
    NavigationStack {
        DictionaryListView()
    }
}
