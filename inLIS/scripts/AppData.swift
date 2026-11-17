//
//  AppData.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// AppData.swift
// ObservableObject che contiene i dati di esempio dell'app
import SwiftUI
import Combine
import Observation

class AppData: ObservableObject {
    private let progressKey = "progress.v1"
    private let learnedWordsKey = "learnedWords.v1"

    // Lista di lezioni/unità (esempio)
    // 6 unità, con i primi 4 titoli specifici richiesti
    @Published var lessons: [Lesson] = [
        Lesson(number: 1, title: "Alfabeto"),
        Lesson(number: 2, title: "Famiglia"),
        Lesson(number: 3, title: "Casa"),
        Lesson(number: 4, title: "Lavoro"),
        Lesson(number: 5, title: "Unit 5"),
        Lesson(number: 6, title: "Unit 6")
    ]
    
    // Voci del dizionario di esempio
    @Published var dictionaryEntries: [DictionaryEntry] = [
        DictionaryEntry(word: "Amico", meaning: "Friend", semanticField: "Family"),
        DictionaryEntry(word: "Padre", meaning: "Father", semanticField: "Family"),
        DictionaryEntry(word: "Casa", meaning: "House", semanticField: "Home"),
        DictionaryEntry(word: "Ciao", meaning: "Hello", semanticField: "Greetings")
    ]
    
    // Flashcards di esempio
    @Published var flashcards: [FlashcardModel] = [
        FlashcardModel(gifName: "ita.a.ciao.segno", answer: "Ciao"),
        FlashcardModel(gifName: "ita.a.bravo.segno", answer: "Bravo"),
        FlashcardModel(gifName: "ita.n.arte.segno", answer: "Arte"),
        FlashcardModel(gifName: "ita.n.gioco.segno", answer: "Gioco"),
        FlashcardModel(gifName: "ita.n.bambino.segno", answer: "Bambino"),
        FlashcardModel(gifName: "ita.v.leggere.segno", answer: "Leggere"),
        FlashcardModel(gifName: "ita.n.casa.segno", answer: "Casa"),
        FlashcardModel(gifName: "ita.n.dottore.segno", answer: "Dottore"),
        FlashcardModel(gifName: "ita.n.fratello.segno", answer: "Fratello"),
    ]
    
    // Domande di esempio organizzate per unità -> esercizi -> domande
    // Ogni unità ha 6 esercizi; ogni esercizio ha 5 domande
    // Puoi personalizzare liberamente ogni domanda
    @Published var sampleExercises: [[[Question]]] = [
        // Unit 1 - Alfabeto
        [
            // Esercizio 1 (5 domande)
            [
                Question(prompt: "What letter does this sign represent?", assetName:"a", choices: ["A","B","C","D"], correctIndex: 0, learnedWordKey: "A"),
                Question(prompt: "Can you tell which letter this is?", assetName:"g", choices: ["E","F","G","H"], correctIndex: 2, learnedWordKey: "G"),
                Question(prompt: "What letter am I signing?", assetName:"e", choices: ["D","E","U","Z"], correctIndex: 1, learnedWordKey: "E"),
                Question(prompt: "Which letter is this?", assetName:"i", choices: ["A","O","R","I"], correctIndex: 3, learnedWordKey: "I"),
                Question(prompt: "Which letter corresponds to this sign?", assetName:"r", choices: ["R","T","P","E"], correctIndex: 0, learnedWordKey: "R"),
            ],
            // Esercizio 2 (5 domande diverse)
            [
                Question(prompt: "Can you tell which letter this is?", assetName:"b", choices: ["A","B","C","D"], correctIndex: 1, learnedWordKey: "B"),
                Question(prompt: "What letter does this sign represent?", assetName:"c", choices: ["G","F","C","H"], correctIndex: 2, learnedWordKey: "C"),
                Question(prompt: "What letter am I signing?", assetName:"d", choices: ["Z","E","U","D"], correctIndex: 3, learnedWordKey: "D"),
                Question(prompt: "Which letter corresponds to this sign?", assetName:"l", choices: ["R","O","L","I"], correctIndex: 2, learnedWordKey: "L"),
                Question(prompt: "Which letter is this?", assetName:"m", choices: ["M","T","R","E"], correctIndex: 0, learnedWordKey: "M"),
            ],
            // Esercizio 3
            [
                Question(prompt: "What letter am I signing?", assetName:"n", choices: ["V","M","N","U"], correctIndex: 2, learnedWordKey: "N"),
                Question(prompt: "Which letter is this?", assetName:"o", choices: ["Q","O","C","G"], correctIndex: 1, learnedWordKey: "O"),
                Question(prompt: "What letter does this sign represent?", assetName:"p", choices: ["R","B","D","P"], correctIndex: 3, learnedWordKey: "P"),
                Question(prompt: "Can you tell which letter this is?", assetName:"q", choices: ["Q","O","G","C"], correctIndex: 0, learnedWordKey: "Q"),
                Question(prompt: "Which letter corresponds to this sign?", assetName:"s", choices: ["X","Z","S","C"], correctIndex: 2, learnedWordKey: "S"),
            ],
            // Esercizio 4
            [
                Question(prompt: "Which letter is this?", assetName:"t", choices: ["T","F","Y","I"], correctIndex: 0, learnedWordKey: "T"),
                Question(prompt: "What letter does this sign represent?", assetName:"u", choices: ["U","V","W","Y"], correctIndex: 0, learnedWordKey: "U"),
                Question(prompt: "What letter am I signing?", assetName:"v", choices: ["V","U","Y","X"], correctIndex: 0, learnedWordKey: "V"),
                Question(prompt: "Can you tell which letter this is?", assetName:"z", choices: ["Z","S","X","C"], correctIndex: 0, learnedWordKey: "Z"),
                Question(prompt: "Which letter corresponds to this sign?", assetName:"h", choices: ["H","N","M","K"], correctIndex: 0, learnedWordKey: "H"),
            ],
            // Esercizio 5
            [
                Question(prompt: "What letter am I signing?", assetName:"f", choices: ["F","E","P","R"], correctIndex: 0, learnedWordKey: "F"),
                Question(prompt: "What letter does this sign represent?", assetName:"j", choices: ["J","I","L","T"], correctIndex: 0, learnedWordKey: "J"),
                Question(prompt: "Can you tell which letter this is?", assetName:"k", choices: ["K","H","N","M"], correctIndex: 0, learnedWordKey: "K"),
                Question(prompt: "Which letter corresponds to this sign?", assetName:"w", choices: ["W","V","U","Y"], correctIndex: 0, learnedWordKey: "W"),
                Question(prompt: "Which letter is this?", assetName:"x", choices: ["X","Z","S","C"], correctIndex: 0, learnedWordKey: "X"),
            ],
            // Esercizio 6
            [
                Question(prompt: "Can you tell which letter this is?", assetName:"r", choices: ["R","T","P","E"], correctIndex: 0, learnedWordKey: "R"),
                Question(prompt: "What letter does this sign represent?", assetName:"a", choices: ["A","B","C","D"], correctIndex: 0, learnedWordKey: "A"),
                Question(prompt: "What letter am I signing?", assetName:"e", choices: ["D","E","U","Z"], correctIndex: 1, learnedWordKey: "E"),
                Question(prompt: "Which letter is this?", assetName:"i", choices: ["A","O","R","I"], correctIndex: 3, learnedWordKey: "I"),
                Question(prompt: "Which letter corresponds to this sign?", assetName:"g", choices: ["E","F","G","H"], correctIndex: 2, learnedWordKey: "G"),
            ],
        ],
        // Unit 2 - Famiglia
        [
            [
                Question(prompt: "What does this sign mean?", assetName:"ita.n.bambino.segno.gif", choices: ["Padre","Sorella","Zio","Bambino"], correctIndex: 3, learnedWordKey: "Bambino"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.padre.segno.gif", choices: ["Zio","Mamma","Padre","Nonno"], correctIndex: 2, learnedWordKey: "Papà"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.mamma.segno.gif", choices: ["Padre","Mamma","Zia","Nonna"], correctIndex: 1, learnedWordKey: "Mamma"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.fratello.segno.gif", choices: ["Cugino","Nonno","Zio","Fratello"], correctIndex: 3, learnedWordKey: "Fratello"),
                Question(prompt: "What’s the translation of this sign?", assetName:"sorella.gif", choices: ["Sorella","Zia","Cugina","Madre"], correctIndex: 0, learnedWordKey: "Sorella"),
            ],
            [
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.nonno.segno.gif", choices: ["Nonno","Zio","Padre","Cugino"], correctIndex: 0, learnedWordKey: "Nonno"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.moglie.segno.gif", choices: ["Zia","Moglie","Sorella","Madre"], correctIndex: 1, learnedWordKey: "Moglie"),
                Question(prompt: "Which word is being signed?", assetName:"zio.gif", choices: ["Nonno","Cugino","Zio","Padre"], correctIndex: 2, learnedWordKey: "Zio"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"nipote.gif", choices: ["Zia","Cugina","Nonna","Nipote"], correctIndex: 3, learnedWordKey: "Nipote"),
                Question(prompt: "What’s the translation of this sign?", assetName:"sorella.gif", choices: ["Cugino","Sorella","Zio","Padre"], correctIndex: 1, learnedWordKey: "Sorella"),
            ],
            [
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.figlio.segno.gif", choices: ["Figlio","Padre","Zio","Cugino"], correctIndex: 0, learnedWordKey: "Figlio"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.mamma.segno.gif", choices: ["Figlia","Mamma","Zia","Cugina"], correctIndex: 1, learnedWordKey: "Mamma"),
                Question(prompt: "What does this sign mean?", assetName:"zio.gif", choices: ["Marito","Padre","Nonno","Zio"], correctIndex: 3, learnedWordKey: "Zio"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.nonno.segno.gif", choices: ["Moglie","Madre","Zia","Nonno"], correctIndex: 3, learnedWordKey: "Nonno"),
                Question(prompt: "Which word is being signed?", assetName:"nipote.gif", choices: ["Padre","Nonno","Nipote","Zio"], correctIndex: 2, learnedWordKey: "Nipote"),
            ],
            [
                Question(prompt: "Which word is being signed?", assetName:"ita.n.fratello.segno.gif", choices: ["Famiglia","Parenti","Amici","Fratello"], correctIndex: 3, learnedWordKey: "Famiglia"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.mamma.segno.gif", choices: ["Parente","Amico","Mamma","Sconosciuto"], correctIndex: 2, learnedWordKey: "Parente"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"sorella.gif", choices: ["Figli","Sorella","Zii","Cugini"], correctIndex: 1, learnedWordKey: "Figli"),
                Question(prompt: "What does this sign mean?", assetName:"zio.gif", choices: ["Fratello","Cugini","Zio","Nonno"], correctIndex: 2, learnedWordKey: "Zii"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.figlio.segno.gif", choices: ["Genitori","Figlo","Zia","Cugina"], correctIndex: 1, learnedWordKey: "Figli"),
            ],
            [
                Question(prompt: "What does this sign mean?", assetName:"nipote.gif", choices: ["Famiglia","Casa","Scuola","Lavoro"], correctIndex: 0, learnedWordKey: "Famiglia"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.nonno.segno.gif", choices: ["Padre","Fratello","Zio","Nonno"], correctIndex: 3, learnedWordKey: "Nonno"),
                Question(prompt: "What word does this sign represent?", assetName:"sorella.gif", choices: ["Madre","Sorella","Zia","Nonna"], correctIndex: 1, learnedWordKey: "Sorella"),
                Question(prompt: "What’s the translation of this sign?", assetName:"zio.gif", choices: ["Bambino","Padre","Cugino","Zio"], correctIndex: 3, learnedWordKey: "Zio"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.mamma.segno.gif", choices: ["Fratello","Nonno","Zio","Cugino"], correctIndex: 2, learnedWordKey: "Mamma"),
            ],
            [
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.nonno.segno.gif", choices: ["Nonno","Zio","Padre","Cugino"], correctIndex: 0, learnedWordKey: "Nonno"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.mamma.segno.gif", choices: ["Zia","Nonna","Sorella","Madre"], correctIndex: 3, learnedWordKey: "Madre"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"zio.gif", choices: ["Zio","Cugino","Nonno","Padre"], correctIndex: 0, learnedWordKey: "Zio"),
                Question(prompt: "Which word is being signed?", assetName:"sorella.gif", choices: ["Zia","Cugina","Nonna","Sorella"], correctIndex: 3, learnedWordKey: "Sorella"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.moglie.segno.gif", choices: ["Moglie","Fratello","Zio","Padre"], correctIndex: 0, learnedWordKey: "Moglie"),
            ],
        ],
        // Unit 3 - Casa
        [
            [
                Question(prompt: "What does this sign mean?", assetName:"ita.n.casa.segno.gif", choices: ["Casa","Scuola","Ufficio","Parco"], correctIndex: 0, learnedWordKey: "Casa"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.camera.segno.gif", choices: ["Casa","Ufficio","Parco","Camera"], correctIndex: 3, learnedWordKey: "Camera"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.giardino.segno.gif", choices: ["Casa","Finestra","Giardino","Cucina"], correctIndex: 2, learnedWordKey: "Giardino"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.muro.segno.gif", choices: ["Finestra","Muro","Tavolo","Sedia"], correctIndex: 1, learnedWordKey: "Muro"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.abitare.segno.gif", choices: ["Abitare","Invitare","Entrare","Arrivare"], correctIndex: 0, learnedWordKey: "Abitare"),
            ],
            [
                Question(prompt: "What does this sign mean?", assetName:"ita.n.giardino.segno.gif", choices: ["Casa","Scuola","Ufficio","Giardino"], correctIndex: 3, learnedWordKey: "Giardino"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.finestra.segno.gif", choices: ["Casa","Finestra","Parco","Camera"], correctIndex: 1, learnedWordKey: "Finestra"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.casa.segno.gif", choices: ["Casa","Finestra","Giardino","Cucina"], correctIndex: 0, learnedWordKey: "Casa"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.abitare.segno.gif", choices: ["Abitare","Invitare","Entrare","Arrivare"], correctIndex: 0, learnedWordKey: "Abitare"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.camera.segno.gif", choices: ["Cucina","Camera","Finestra","Giardino"], correctIndex: 1, learnedWordKey: "Camera"),
            ],
            [
                Question(prompt: "What does this sign mean?", assetName:"ita.n.casa.segno.gif", choices: ["Casa","Scuola","Ufficio","Parco"], correctIndex: 0, learnedWordKey: "Casa"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.camera.segno.gif", choices: ["Casa","Ufficio","Parco","Camera"], correctIndex: 3, learnedWordKey: "Camera"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.giardino.segno.gif", choices: ["Casa","Finestra","Giardino","Cucina"], correctIndex: 2, learnedWordKey: "Giardino"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.muro.segno.gif", choices: ["Finestra","Muro","Tavolo","Sedia"], correctIndex: 1, learnedWordKey: "Muro"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.abitare.segno.gif", choices: ["Abitare","Invitare","Entrare","Arrivare"], correctIndex: 0, learnedWordKey: "Abitare"),
            ],
            [
                Question(prompt: "What does this sign mean?", assetName:"ita.n.casa.segno.gif", choices: ["Casa","Scuola","Ufficio","Parco"], correctIndex: 0, learnedWordKey: "Casa"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.camera.segno.gif", choices: ["Casa","Ufficio","Parco","Camera"], correctIndex: 3, learnedWordKey: "Camera"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.giardino.segno.gif", choices: ["Casa","Finestra","Giardino","Cucina"], correctIndex: 2, learnedWordKey: "Giardino"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.muro.segno.gif", choices: ["Finestra","Muro","Tavolo","Sedia"], correctIndex: 1, learnedWordKey: "Muro"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.abitare.segno.gif", choices: ["Abitare","Invitare","Entrare","Arrivare"], correctIndex: 0, learnedWordKey: "Abitare"),
            ],
            [
                Question(prompt: "What does this sign mean?", assetName:"ita.n.casa.segno.gif", choices: ["Casa","Scuola","Ufficio","Parco"], correctIndex: 0, learnedWordKey: "Casa"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.camera.segno.gif", choices: ["Casa","Ufficio","Parco","Camera"], correctIndex: 3, learnedWordKey: "Camera"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.giardino.segno.gif", choices: ["Casa","Finestra","Giardino","Cucina"], correctIndex: 2, learnedWordKey: "Giardino"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.muro.segno.gif", choices: ["Finestra","Muro","Tavolo","Sedia"], correctIndex: 1, learnedWordKey: "Muro"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.abitare.segno.gif", choices: ["Abitare","Invitare","Entrare","Arrivare"], correctIndex: 0, learnedWordKey: "Abitare"),
            ],
            [
                Question(prompt: "What does this sign mean?", assetName:"ita.n.casa.segno.gif", choices: ["Casa","Scuola","Ufficio","Parco"], correctIndex: 0, learnedWordKey: "Casa"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.camera.segno.gif", choices: ["Casa","Ufficio","Parco","Camera"], correctIndex: 3, learnedWordKey: "Camera"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.giardino.segno.gif", choices: ["Casa","Finestra","Giardino","Cucina"], correctIndex: 2, learnedWordKey: "Giardino"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.muro.segno.gif", choices: ["Finestra","Muro","Tavolo","Sedia"], correctIndex: 1, learnedWordKey: "Muro"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.abitare.segno.gif", choices: ["Abitare","Invitare","Entrare","Arrivare"], correctIndex: 0, learnedWordKey: "Abitare"),
            ],
        ],
        // Unit 4 - Lavoro
        [
            [
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.avvocato.segno.gif", choices: ["Capo","Collega","Avvocato","Dottore"], correctIndex: 2, learnedWordKey: "Avvocato"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.giudice.segno.gif", choices: ["Collega","Capo","Avvocato","Giudice"], correctIndex: 3, learnedWordKey: "Giudice"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.capo.segno.gif", choices: ["Capo","Dottore","Collega","Giudice"], correctIndex: 0, learnedWordKey: "Capo"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.dottore.segno.gif", choices: ["Giudice","Dottore","Collega","Capo"], correctIndex: 1, learnedWordKey: "Dottore"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.collega.segno.gif", choices: ["Collega","Dottore","Avvocato","Giudice"], correctIndex: 0, learnedWordKey: "Collega"),
                
            ],
            [
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.professore.segno.gif", choices: ["Collega","Capo","Avvocato","Professore"], correctIndex: 3, learnedWordKey: "Professore"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.avvocato.segno.gif", choices: ["Capo","Collega","Avvocato","Dottore"], correctIndex: 2, learnedWordKey: "Avvocato"),
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.lavorare.segno.gif", choices: ["Lavorare","Scrivere","Licenziare","Assumere"], correctIndex: 0, learnedWordKey: "Lavorare"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.collega.segno.gif", choices: ["Collega","Dottore","Avvocato","Giudice"], correctIndex: 0, learnedWordKey: "Collega"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.dottore.segno.gif", choices: ["Giudice","Dottore","Collega","Capo"], correctIndex: 1, learnedWordKey: "Dottore"),

            ],
            [
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.lavorare.segno.gif", choices: ["Lavorare","Scrivere","Licenziare","Assumere"], correctIndex: 0, learnedWordKey: "Lavorare"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.giudice.segno.gif", choices: ["Collega","Capo","Avvocato","Giudice"], correctIndex: 3, learnedWordKey: "Giudice"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.dottore.segno.gif", choices: ["Giudice","Dottore","Collega","Capo"], correctIndex: 1, learnedWordKey: "Dottore"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.professore.segno.gif", choices: ["Collega","Capo","Avvocato","Professore"], correctIndex: 3, learnedWordKey: "Professore"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.capo.segno.gif", choices: ["Capo","Dottore","Collega","Giudice"], correctIndex: 0, learnedWordKey: "Capo"),
                
            ],
            [
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.avvocato.segno.gif", choices: ["Capo","Collega","Avvocato","Dottore"], correctIndex: 2, learnedWordKey: "Avvocato"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.giudice.segno.gif", choices: ["Collega","Capo","Avvocato","Giudice"], correctIndex: 3, learnedWordKey: "Giudice"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.capo.segno.gif", choices: ["Capo","Dottore","Collega","Giudice"], correctIndex: 0, learnedWordKey: "Capo"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.dottore.segno.gif", choices: ["Giudice","Dottore","Collega","Capo"], correctIndex: 1, learnedWordKey: "Dottore"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.collega.segno.gif", choices: ["Collega","Dottore","Avvocato","Giudice"], correctIndex: 0, learnedWordKey: "Collega"),
                
            ],
            [
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.avvocato.segno.gif", choices: ["Capo","Collega","Avvocato","Dottore"], correctIndex: 2, learnedWordKey: "Avvocato"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.giudice.segno.gif", choices: ["Collega","Capo","Avvocato","Giudice"], correctIndex: 3, learnedWordKey: "Giudice"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.capo.segno.gif", choices: ["Capo","Dottore","Collega","Giudice"], correctIndex: 0, learnedWordKey: "Capo"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.dottore.segno.gif", choices: ["Giudice","Dottore","Collega","Capo"], correctIndex: 1, learnedWordKey: "Dottore"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.collega.segno.gif", choices: ["Collega","Dottore","Avvocato","Giudice"], correctIndex: 0, learnedWordKey: "Collega"),
                
            ],
            [
                Question(prompt: "What’s the translation of this sign?", assetName:"ita.n.avvocato.segno.gif", choices: ["Capo","Collega","Avvocato","Dottore"], correctIndex: 2, learnedWordKey: "Avvocato"),
                Question(prompt: "What word does this sign represent?", assetName:"ita.n.giudice.segno.gif", choices: ["Collega","Capo","Avvocato","Giudice"], correctIndex: 3, learnedWordKey: "Giudice"),
                Question(prompt: "Which word is being signed?", assetName:"ita.n.capo.segno.gif", choices: ["Capo","Dottore","Collega","Giudice"], correctIndex: 0, learnedWordKey: "Capo"),
                Question(prompt: "What’s the Italian word for this sign?", assetName:"ita.n.dottore.segno.gif", choices: ["Giudice","Dottore","Collega","Capo"], correctIndex: 1, learnedWordKey: "Dottore"),
                Question(prompt: "What does this sign mean?", assetName:"ita.n.collega.segno.gif", choices: ["Collega","Dottore","Avvocato","Giudice"], correctIndex: 0, learnedWordKey: "Collega"),
                
            ]
        ]
    ]
    
    // Stato di avanzamento: per ogni unità, array di Bool per ciascun esercizio
    // Esempio: progress[unitIndex][exerciseIndex] == true se completato.
    @Published var progress: [[Bool]] = []

    // Nuovo: insieme delle parole apprese (chiave = DictionaryEntry.word)
    @Published var learnedWords: Set<String> = []
    
    @Published var parole = [
        ParoleDelGiorno (gifName: "ita.a.ciao.segno", description: "CIAO"),
        ParoleDelGiorno(gifName: "ita.n.arte.segno", description: "ARTE"),
        ParoleDelGiorno(gifName: "ita.n.gioco.segno", description: "GIOCO"),
        ParoleDelGiorno(gifName: "ita.n.napoli.segno", description: "NAPOLI"),
        ParoleDelGiorno(gifName: "ita.n.segno.segno", description: "SEGNO")
    ]
    
    init() {// cancella per azzerare i progressi per tornare alla situazione di default
        // Try to load persisted progress and learned words; fall back to defaults
        if let savedProgress = UserDefaults.standard.array(forKey: progressKey) as? [[Bool]] {
            self.progress = savedProgress
        } else {
            // Initialize progress with false for each exercise in each unit
            self.progress = sampleExercises.map { unit in
                Array(repeating: false, count: unit.count)
            }
        }

        if let savedLearned = UserDefaults.standard.array(forKey: learnedWordsKey) as? [String] {
            self.learnedWords = Set(savedLearned)
        } else {
            self.learnedWords = []
        }
        
        // Sincronizza progress con la struttura corrente di sampleExercises (evita out-of-bounds)
        normalizeProgressShape()
    } // fino a qui
    
    // Helper: segna completato un esercizio
    func markCompleted(unitIndex: Int, exerciseIndex: Int) {
        // Verifica che l'indice richiesto esista in sampleExercises
        guard sampleExercises.indices.contains(unitIndex),
              sampleExercises[unitIndex].indices.contains(exerciseIndex) else { return }
        
        // Assicura che progress abbia la forma corretta prima di scrivere
        ensureProgressCapacity(for: unitIndex)
        ensureExerciseCapacity(for: unitIndex)
        
        // Ora è sicuro scrivere
        progress[unitIndex][exerciseIndex] = true
        UserDefaults.standard.set(progress, forKey: progressKey)
    }

    // Nuovo: marca una parola come appresa
    func markLearned(word: String) {
        learnedWords.insert(word)
        UserDefaults.standard.set(Array(learnedWords), forKey: learnedWordsKey)
    }

    // Nuovo: controlla se una parola è appresa
    func isLearned(word: String) -> Bool {
        learnedWords.contains(word)
    }
    
    // MARK: - Normalizzazione forma progress
    
    // Porta progress ad avere esattamente lo stesso numero di unità e di esercizi per unità di sampleExercises
    private func normalizeProgressShape() {
        // Allinea numero di unità
        if progress.count != sampleExercises.count {
            progress = (0..<sampleExercises.count).map { unitIdx in
                let expectedExercises = sampleExercises[unitIdx].count
                let existing = (unitIdx < progress.count) ? progress[unitIdx] : []
                if existing.count == expectedExercises {
                    return existing
                } else {
                    // Crea un array di false della lunghezza attesa (per semplicità)
                    return Array(repeating: false, count: expectedExercises)
                }
            }
            UserDefaults.standard.set(progress, forKey: progressKey)
        } else {
            // Stesso numero di unità: assicurati che ogni unità abbia il numero di esercizi corretto
            var changed = false
            for unitIdx in 0..<progress.count {
                let expected = sampleExercises[unitIdx].count
                if progress[unitIdx].count != expected {
                    progress[unitIdx] = Array(repeating: false, count: expected)
                    changed = true
                }
            }
            if changed {
                UserDefaults.standard.set(progress, forKey: progressKey)
            }
        }
    }
    
    // Garantisce che progress abbia almeno unitIndex + 1 unità
    private func ensureProgressCapacity(for unitIndex: Int) {
        if progress.count <= unitIndex {
            // Estendi fino a unitIndex inclusivo
            let unitsToAdd = unitIndex - progress.count + 1
            for i in 0..<unitsToAdd {
                let expectedExercises = sampleExercises[progress.count + i].count
                progress.append(Array(repeating: false, count: expectedExercises))
            }
        }
    }
    
    // Garantisce che progress[unitIndex] abbia esattamente il numero di esercizi atteso
    private func ensureExerciseCapacity(for unitIndex: Int) {
        let expected = sampleExercises[unitIndex].count
        if progress[unitIndex].count != expected {
            progress[unitIndex] = Array(repeating: false, count: expected)
        }
    }
}

