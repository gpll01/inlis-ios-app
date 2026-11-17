//
//  PathView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// PathView.swift
// Mappa lezioni per unità: titolo grande e 6 bottoni esercizi sotto ciascuna unità
import SwiftUI

// Rotta semplice per identificare esercizi: unità + indice esercizio
struct ExerciseRoute: Hashable {
    let unitIndex: Int
    let exerciseIndex: Int
}

struct PathView: View {
    @EnvironmentObject var data: AppData
    @State private var collapsed = false
    @State private var showingWord = false
    // Stack di navigazione per spingere esercizi
    @State private var path: [ExerciseRoute] = []
    
    // 3 colonne fisse per i bottoni esercizi
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12, alignment: .center), count: 3)
    
    // Costruisce i dati delle prime 4 unità con 6 esercizi ciascuna
    private var units: [(unitIndex: Int, unitNumber: Int, title: String)] {
        let desiredTitles: [Int: String] = [
            1: "Alphabet",
            2: "Family",
            3: "Home",
            4: "Job"
        ]
        
        // Help the compiler with explicit typing and simpler steps
        let result: [(unitIndex: Int, unitNumber: Int, title: String)] = (1...4).map { (idx: Int) -> (unitIndex: Int, unitNumber: Int, title: String) in
            let unitIndex: Int = idx - 1
            let titleFromData: String
            if data.lessons.indices.contains(unitIndex) {
                titleFromData = data.lessons[unitIndex].title
            } else {
                titleFromData = "Unit \(idx)"
            }
            let overrideTitle: String? = desiredTitles[idx]
            let finalTitle: String = overrideTitle ?? titleFromData
            return (unitIndex: unitIndex, unitNumber: idx, title: finalTitle)
        }
        return result
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                GeometryReader { geo in
                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .named("scroll")).minY)
                }
                .frame(height: 0)
                
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(units, id: \.unitNumber) { unit in
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Unit \(unit.unitNumber): \(unit.title)")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(Color(hex: "1C5D9C"))
                                .padding(.horizontal, 4)
                            
                            // 6 bottoni esercizi (2 righe x 3 colonne)
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(0..<6, id: \.self) { exerciseIndex in
                                    
                                    // Regola di sblocco:
                                    // - esercizio 0 sempre sbloccato
                                    // - esercizio N sbloccato se N-1 è completato
                                    let isUnlocked: Bool = {
                                        if exerciseIndex == 0 { return true }
                                        guard data.progress.indices.contains(unit.unitIndex),
                                              data.progress[unit.unitIndex].indices.contains(exerciseIndex - 1) else {
                                            return false
                                        }
                                        return data.progress[unit.unitIndex][exerciseIndex - 1]
                                    }()
                                    
                                    Button {
                                        guard isUnlocked else { return }
                                        // Push della rotta: apri l’esercizio richiesto
                                        path.append(ExerciseRoute(unitIndex: unit.unitIndex, exerciseIndex: exerciseIndex))
                                    } label: {
                                        ZStack {
                                            ExerciseButton(number: exerciseIndex + 1)
                                                .frame(width: 80, height: 80)
                                                .overlay(
                                                    Group {
                                                        if !isUnlocked {
                                                            Color.black.opacity(0.35)
                                                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                                            Image(systemName: "lock.fill")
                                                                .foregroundColor(.white)
                                                                .font(.system(size: 18, weight: .bold))
                                                        } else if data.progress.indices.contains(unit.unitIndex),
                                                                  data.progress[unit.unitIndex].indices.contains(exerciseIndex),
                                                                  data.progress[unit.unitIndex][exerciseIndex] == true {
                                                        }
                                                    }
                                                )
                                        }
                                    }
                                    .buttonStyle(.plain)
                                    .disabled(!isUnlocked)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 60)
                .padding(.top, 8)
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                withAnimation(.easeInOut(duration: 0.15)) {
                    collapsed = (value < -20)
                }
            }
            .navigationTitle(collapsed ? "path".lowercased() : "Path")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingWord = true
                    } label: {
                        Image(systemName: "dice")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .accessibilityLabel("Parola del giorno")
                }
            }
            .navigationDestination(isPresented: $showingWord) {
                WordOfTheDayView()
            }
            .background(Color(hex:"F8E5D5").ignoresSafeArea())
            // Destinazione per le rotte esercizi
            .navigationDestination(for: ExerciseRoute.self) { route in
                // Recupera domande in sicurezza
                let questions: [Question] = {
                    if data.sampleExercises.indices.contains(route.unitIndex),
                       data.sampleExercises[route.unitIndex].indices.contains(route.exerciseIndex) {
                        return data.sampleExercises[route.unitIndex][route.exerciseIndex]
                    }
                    return []
                }()
                
                // Validazione anti-deeplink: evita di aprire esercizi bloccati
                let canOpen: Bool = {
                    if route.exerciseIndex == 0 { return true }
                    guard data.progress.indices.contains(route.unitIndex),
                          data.progress[route.unitIndex].indices.contains(route.exerciseIndex - 1) else {
                        return false
                    }
                    return data.progress[route.unitIndex][route.exerciseIndex - 1]
                }()
                
                if canOpen {
                    ExerciseView(
                        questions: questions,
                        unitTitle: "Exercise \(route.exerciseIndex + 1)",
                        unitIndex: route.unitIndex,
                        exerciseIndex: route.exerciseIndex,
                        onNavigateNext: { unitIdx, nextExercise in
                            // Push della prossima rotta
                            path.append(ExerciseRoute(unitIndex: unitIdx, exerciseIndex: nextExercise))
                        }
                    )
                } else {
                    // Schermata placeholder se l’utente prova a saltare
                    VStack(spacing: 16) {
                        Text("Completa prima l’esercizio precedente")
                            .font(.headline)
                            .foregroundColor(.red)
                        Button("Torna indietro") {
                            // pop
                            _ = path.popLast()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(hex:"F8E5D5").ignoresSafeArea())
                }
            }
        }
    }
}

/// Bottone esercizio (numerato) con stile coerente
struct ExerciseButton: View {
    let number: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "05C5F0"), Color(hex: "006075")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
            
            Text("\(number)")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        // il frame 80x80 viene applicato dal chiamante per garantire la forma quadrata
    }
}

// Mantieni anche il LessonButton se lo usi altrove
struct LessonButton: View {
    let number: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "05C5F0"), Color(hex: "006075")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
            
            Text("\(number)")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

// Safe indexing helper locale (evita crash se mancano dati)
private extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

