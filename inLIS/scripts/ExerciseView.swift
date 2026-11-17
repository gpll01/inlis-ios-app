//
//  ExerciseView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

import SwiftUI

struct ExerciseView: View {
    @EnvironmentObject var data: AppData
    @Environment(\.dismiss) var dismiss

    // Stato dell’esercizio corrente
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedChoiceIndex: Int? = nil
    @State private var showCompleted: Bool = false
    @State private var score = 0

    // Parametri iniziali passati dal chiamante
    let questions: [Question]
    let unitTitle: String
    let unitIndex: Int
    let exerciseIndex: Int

    // Callback opzionale per navigare alla prossima schermata esercizio
    var onNavigateNext: ((Int, Int) -> Void)? = nil

    // Copie mutabili locali per permettere il passaggio automatico all’esercizio successivo
    @State private var currentQuestions: [Question] = []
    @State private var currentUnitTitle: String = ""
    @State private var currentExerciseIndex: Int = 0

    // 2 colonne adattive
    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack {
            // --- Conteuto principale ---
            Group {
                if currentQuestions.isEmpty {
                    VStack(spacing: 20) {
                        HStack(spacing: 12) {
                            Button(action: {
                                dismiss()
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 3)
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                                .frame(width: 36, height: 36)
                            }

                            Text(currentUnitTitle.isEmpty ? unitTitle : currentUnitTitle)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color(hex: "0095B6"))
                        }
                        .padding(.top, 8)

                        Spacer()

                        Text("Nessuna domanda disponibile per questo esercizio.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)

                        Button("Chiudi") {
                            dismiss() // pop
                        }
                        .padding(.top, 8)

                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .background(Color(hex: "F8E5D5").ignoresSafeArea())
                    .onAppear {
                        currentQuestions = questions
                        currentUnitTitle = unitTitle
                        currentExerciseIndex = exerciseIndex
                    }

                } else {
                    VStack(alignment: .leading) {
                        // --- Header con chevron e titolo ---
                        ZStack {
                            HStack(spacing: 12) {
                                // Chevron che fa pop
                                Button(action: {
                                    dismiss() // pop
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(.ultraThinMaterial)
                                            .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 3)
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 36, height: 36)
                                }

                                Text(currentUnitTitle)
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color(hex: "0095B6"))
                            }
                            .padding(.leading, 16)
                            .padding(.top, 8)
                        }
                        .frame(height: 100, alignment: .leading)

                        // --- Prompt + media ---
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "0095B6"))
                            .frame(height: 240)
                            .overlay(
                                VStack(spacing: -20) {
                                    Text(currentQuestions[currentQuestionIndex].prompt)
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                        .padding(.bottom, 40)

                                    if currentQuestions[currentQuestionIndex].assetName.lowercased().hasSuffix(".gif") {
                                        GIFView(gifName: currentQuestions[currentQuestionIndex].assetName
                                            .replacingOccurrences(of: ".gif", with: ""))
                                            .frame(width: 230, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Image(currentQuestions[currentQuestionIndex].assetName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            )
                            .padding(.horizontal, 22)

                        Spacer()

                        // --- Scelte multiple ---
                        LazyVGrid(columns: gridColumns, alignment: .center, spacing: 50) {
                            ForEach(0..<currentQuestions[currentQuestionIndex].choices.count, id: \.self) { idx in
                                ChoiceRow(
                                    text: currentQuestions[currentQuestionIndex].choices[idx],
                                    index: idx,
                                    selectedIndex: selectedChoiceIndex,
                                    correctIndex: currentQuestions[currentQuestionIndex].correctIndex
                                )
                                .onTapGesture {
                                    guard selectedChoiceIndex == nil else { return }
                                    selectedChoiceIndex = idx
                                    if idx == currentQuestions[currentQuestionIndex].correctIndex {
                                        score += 1
                                        if let word = currentQuestions[currentQuestionIndex].learnedWordKey {
                                            data.markLearned(word: word)
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                        goToNext()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                    .background(Color(hex: "F8E5D5").ignoresSafeArea())
                    .navigationBarBackButtonHidden(true)
                    .navigationDestination(isPresented: $showCompleted) {
                        CompletedExerciseView(
                            score: score,
                            total: currentQuestions.count,
                            onRepeat: {
                                resetForCurrentExercise()
                                showCompleted = false
                            },
                            onNext: {
                                let nextExercise = currentExerciseIndex + 1
                                let exercisesInUnit = data.sampleExercises[unitIndex].count
                                guard nextExercise < exercisesInUnit else {
                                    // se era l’ultimo esercizio dell’unità, torna alla Path
                                    dismiss()
                                    return
                                }

                                if let onNavigateNext {
                                    onNavigateNext(unitIndex, nextExercise)
                                } else {
                                    let nextQuestions = data.sampleExercises[unitIndex][nextExercise]
                                    currentExerciseIndex = nextExercise
                                    currentQuestions = nextQuestions
                                    currentUnitTitle = "Exercise \(nextExercise + 1)"
                                    resetForCurrentExercise()
                                    showCompleted = false
                                }
                            }
                        )
                    }
                    .onAppear {
                        currentQuestions = questions
                        currentUnitTitle = unitTitle
                        currentExerciseIndex = exerciseIndex
                    }
                }
            } // End Group (contenuto)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } // End ZStack
    }

    // --- Navigazione tra domande ---
    func goToNext() {
        selectedChoiceIndex = nil
        if currentQuestionIndex + 1 < currentQuestions.count {
            currentQuestionIndex += 1
        } else {
            data.markCompleted(unitIndex: unitIndex, exerciseIndex: currentExerciseIndex)
            showCompleted = true
        }
    }

    // --- Reset ---
    func resetForCurrentExercise() {
        selectedChoiceIndex = nil
        currentQuestionIndex = 0
        score = 0
    }
}

// --- Scelta singola ---
struct ChoiceRow: View {
    let text: String
    let index: Int
    let selectedIndex: Int?
    let correctIndex: Int

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                choiceBackground
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray.opacity(0.1))
                    )
                    .cornerRadius(12)

                Text(text)
                    .foregroundColor(Color(hex: "0095B6"))
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .lineLimit(3)
                    .padding(12)
            }
            .frame(width: 160, height: 160)
            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
        .frame(height: 140)
    }

    var choiceBackground: Color {
        guard let sel = selectedIndex else { return Color.white }
        if sel == index {
            return (index == correctIndex) ? Color.green.opacity(0.85) : Color.red.opacity(0.85)
        } else {
            if sel != correctIndex && index == correctIndex {
                return Color.green.opacity(0.5)
            } else {
                return Color.white
            }
        }
    }
}

#Preview {
    ContentView()
}
