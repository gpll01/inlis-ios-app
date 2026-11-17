//
//  WordOfTheDayView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// WordOfTheDayView.swift
// Parola del giorno: scrigno tappabile che apre la parola del giorno al centro dello schermo
import SwiftUI

struct WordOfTheDayView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var data: AppData

    @State private var currentParola: ParoleDelGiorno? = nil
    @State private var showOpenChest = false

    var body: some View {
        ZStack {
            // Sfondo
            Color(red: 0xF8 / 255, green: 0xE5 / 255, blue: 0xD5 / 255)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // Titolo
                Text("Word of the Day")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 0/255, green: 149/255, blue: 182/255))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                // Spinge il contenuto (scrigno) verso il centro verticale
                Spacer()

                // Scrigno tappabile
                VStack(spacing: 40) {
                    ZStack {
                        if !showOpenChest {
                            Image("scrigno chiuso")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .shadow(radius: 30)
                                .transition(.opacity)
                        } else {
                            Image("scrigno aperto")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .shadow(radius: 30)
                                .transition(.opacity)
                            Text("Tap again to get a new word!")
                                .foregroundColor(Color(red: 0/255, green: 149/255, blue: 182/255))
                                .font(.title3)
                                .bold()
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .padding(.top, 190)
                                
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            showOpenChest = true
                            currentParola = data.parole.randomElement()
                        }
                    }

                    if !showOpenChest {
                        Text("Tap to get your word!")
                            .foregroundColor(Color(red: 0/255, green: 149/255, blue: 182/255))
                            .font(.title3)
                            .bold()
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }

                    if let parola = currentParola, showOpenChest {
                        GIFView(gifName: parola.gifName)
                            .id(parola.id)
                            .frame(height: 230)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                            .padding(.horizontal, 20)

                        Text(parola.description)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(red: 0/255, green: 149/255, blue: 182/255))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                }
                .frame(maxWidth: .infinity)

                // Bilancia verso il centro verticale
                Spacer()
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    ContentView()
}
