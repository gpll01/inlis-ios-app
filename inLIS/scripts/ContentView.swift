//
//  ContentView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// ContentView.swift
// Punto d'entrata per la UI (ContentView) — l'App principale dovrebbe inserire ContentView come root.
import SwiftUI

struct ContentView: View {
    @StateObject private var data = AppData()
    @State private var showWelcome: Bool = true //da cambiare in true per vedere la welcomepage nel simulatore
    
    init() {
        // Imposta colore titoli NavigationBar a #0095B6
        let titleColor = UIColor(Color(hex: "0095B6"))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear // lasciamo trasparente, lo sfondo lo gestiscono le view
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = titleColor
    }
    
    var body: some View {
        Group {
            if showWelcome {
                WelcomeView {
                    withAnimation(.easeInOut) {
                        showWelcome = false
                    }
                }
                .environmentObject(data)
            } else {
                RootTabView()
                    .environmentObject(data)
            }
        }
    }
}

// Preview per ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

