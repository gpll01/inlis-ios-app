//
//  Models.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// Models.swift
// Definizione dei model usati nell'app
import Foundation
import SwiftUI

/// Rappresenta una lezione/unità nella schermata Path
struct Lesson: Identifiable {
    let id = UUID()
    let number: Int
    let title: String
    // aggiungere proprietà come unlocked, score se utile
}

/// Rappresenta una voce del dizionario
struct DictionaryEntry: Identifiable {
    let id = UUID()
    let word: String
    let meaning: String
    let semanticField: String
}

/// Flashcard
struct FlashcardModel: Identifiable {
    let id = UUID()
    let gifName: String
    let answer: String
    // aggiungere assetName per immagine o video se necessario
}

/// Domanda per esercizi
struct Question: Identifiable {
    let id = UUID()
    let prompt: String
    let assetName: String
    let choices: [String] // 4 scelte previste
    let correctIndex: Int
    // aggiungere assetName per immagine/gif se necessario

    // Nuovo: chiave della parola da marcare come appresa quando l’utente risponde correttamente.
    // Deve corrispondere a DictionaryEntry.word
    let learnedWordKey: String?
}

struct ParoleDelGiorno: Identifiable {
    let id = UUID()
    let gifName: String
    let description: String
}
    
// Rendiamo Lesson hashable per eventuali usi in collection navigation-value
extension Lesson: Hashable {
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
/// Modello per la schermata del lessema (parola o lettera)
struct Lexeme: Identifiable, Hashable {
    let id = UUID()
    let title: String                // parola o lettera
    let mainGifName: String          // GIF principale
    let exampleGifName: String       // GIF di esempio
    let exampleCaption: String       // didascalia dell’esempio
}

