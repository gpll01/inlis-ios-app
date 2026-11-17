//
//  FlashcardsView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// FlashcardsView.swift
// Ripetizioni - flashcards centrali che si girano
import SwiftUI

struct FlashcardsView: View {
    @EnvironmentObject var data: AppData
    @State private var currentIndex: Int = 0
    @State private var flipped: Bool = false
    
    var body: some View {
        ZStack {
            // Background su tutto lo schermo
            Color(hex: "F8E5D5")
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Flashcards")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 0/255, green: 149/255, blue: 182/255))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 55)
                
                Spacer()
                
                if data.flashcards.isEmpty {
                    // Empty state sicuro
                    VStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(hex: "006075"))
                            .frame(width: 320, height: 420)
                            .shadow(radius: 4)
                            .overlay(
                                Text("Nessuna flashcard disponibile")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                            )
                        Text("Aggiungi flashcards per iniziare.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                } else {
                    ZStack {
                        // Pannello di sfondo che ruota con la card (fronte/retro)
                                                ZStack {
                                                    // Lato frontale dello sfondo
                                                    RoundedRectangle(cornerRadius: 18)
                                                        .fill(Color(hex: "006075"))
                                                        .opacity(flipped ? 0 : 1)
                                                        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))

                                                    // Lato posteriore dello sfondo (colore leggermente diverso)
                                                    RoundedRectangle(cornerRadius: 18)
                                                        .fill(Color(hex: "005363"))
                                                        .opacity(flipped ? 1 : 0)
                                                        // Il retro parte già girato di 180°, poi segue la rotazione principale
                                                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                                        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                                                }
                                                .frame(width: 320, height: 420)
                                                .shadow(radius: 4)

                                                // Contenuto della card che già ruota
                        
                        CardContentView(flashcard: data.flashcards[safe: currentIndex]!, flipped: $flipped)
                            .frame(width: 300, height: 380)
                            .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                            
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.6)) { flipped.toggle() }
                            }
                    }
                }
                
                Text("Tap the card to flip")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                
                // Un solo pulsante freccia per avanzare
                Button {
                    guard !data.flashcards.isEmpty else { return }
                    withAnimation { flipped = false }
                    currentIndex = (currentIndex + 1) % data.flashcards.count
                } label: {
                    Text("NEXT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color(hex: "006075"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        .accessibilityLabel("Prossima flashcard")
                }
                .padding(.top, 4)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

// Safe indexing helper
private extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

struct CardContentView: View {
    let flashcard: FlashcardModel
    @Binding var flipped: Bool
    
    var body: some View {
        ZStack {
            if !flipped {
                VStack(spacing: 16) {
                    Text("What does this sign mean?")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 12)
                    GIFView(gifName: flashcard.gifName)
                        .id(flashcard.id)
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(height: 230)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding(.horizontal, 20)
                        .allowsHitTesting(false)
                }
                .padding(.horizontal, 1)
                .padding(.bottom, 60)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            } else {
                VStack {
                    Text("It means:")
                        .font(.title)
                        .foregroundColor(.white)
                    Text(flashcard.answer)
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 100)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .cornerRadius(12)
    }
}

#Preview {
    ContentView()
}
