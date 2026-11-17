//
//  SectionView.swift
//  InLIS2
//
//  Created by Ilenia Maiorano on 17/10/25.
//

import SwiftUI

struct SectionView: View {
    @EnvironmentObject var data: AppData
    var title: String
    var words: [String]
    
    // Explicit internal initializer to avoid access-control surprises
    init(title: String, words: [String]) {
        self.title = title
        self.words = words
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !title.isEmpty {
                Text(title)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "1C5D9C"))
                    .padding(.horizontal, 4)
            }
            
            VStack(spacing: 0) {
                ForEach(words, id: \.self) { word in
                    NavigationLink(
                        destination: LexemeView(
                            lexemes: words.map { lexemeFor($0) }, // Passiamo tutte le lettere/parole
                            selectedIndex: words.firstIndex(of: word) ?? 0 // Indice della lettera selezionata
                        )
                    ) {
                        HStack(spacing: 12) {
                            Text(word)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            if data.isLearned(word: word) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.leading, 1)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 2, y: 2)
            )
        }
    }
    
    // MARK: - Factory Lexeme
    private func lexemeFor(_ text: String) -> Lexeme {
        let key = normalize(text)
        
        if isSingleLetter(key) {
            let assetName = "ita.alfabeto.\(key)"
            return Lexeme(
                title: text,
                mainGifName: assetName,
                exampleGifName: assetName,
                exampleCaption: ""
            )
        } else {
            let main = "ita.n.\(key).segno"
            let example = "ita.n.\(key).esempio"
            let caption = exampleCaptionMap[key] ?? "Esempio con “\(text)”."
            
            return Lexeme(
                title: text,
                mainGifName: main,
                exampleGifName: example,
                exampleCaption: caption
            )
        }
    }
    
    private func isSingleLetter(_ key: String) -> Bool {
        key.count == 1 && key.unicodeScalars.allSatisfy { CharacterSet.lowercaseLetters.contains($0) || CharacterSet.uppercaseLetters.contains($0) }
    }
    
    private func normalize(_ text: String) -> String {
        text.lowercased()
            .replacingOccurrences(of: " ", with: ".")
            .folding(options: .diacriticInsensitive, locale: .current)
    }
    
    private var exampleCaptionMap: [String: String] = [
        "abitare": "Ho sempre abitato a Torino.",
        "casa": "Quella casa è enorme, perciò vale molto.",
        "finestra": "Qui c'è puzza, perfavore apri la finestra.",
        "giardino": "Davanti alla mia nuova casa c'è un grande giardino dove posso coltivare i fiori che più mi piacciono.",
        "camera": "In quale camera della casa spesso i sordi si trovano e segnano? La cucina.",
        "bambino": "Mio figlio è molto socievole: ogni volta che lo porto al parco conosce qualche nuovo bambino con cui giocare.",
        "figlio": "La mia collega ha tre figli: due maschi e una femmina.",
        "mamma": "Mia sorella ha otto anni più di me, è sposata ed è mamma di due bambini.",
        "moglie": "Io e mia moglie ci siamo sposati nel settembre del 2004 e ora stiamo per avere il nostro primo figlio.",
        "nonno": "Mio nonno ha 78 anni.",
        "padre": "Stasera andiamo a festeggiare mio fratello che ieri è diventato padre di un maschietto.",
        "sorella": "Tutti dicono che io e mia sorella ci assomigliamo molto. A me non sembra invece perché lei assomiglia a papà mentre io sono molto più simile a mamma.",
        "zio": "Un giorno vorrei farti conoscere mio zio Franco, il fratello di mio padre: gli sono molto affezionato.",
        "libro": "Nonostante il libro avesse più di 400 pagine, l’ho letto tutto in soli due giorni.",
        "leggere": "Leggere è la mia passione. Leggo di tutto: fumetti, romanzi gialli, romanzi storici e libri di fantascienza.",
        "professore": "Mia madre è impiegata in banca e mio padre è professore: insegna chimica al liceo",
        "scrivere": "Durante la lezione di francese, la professoressa ci proponeva spesso la prova di dettato: lei leggeva un testo e uno di noi andava alla lavagna a scrivere",
        "scuola": "Mi sembra che la scuola di oggi non prepari adeguatamente nè al lavoro nè all'università",
        "avvocato": "All'uscita dal carcere, l'avvocato del presunto assassino si è detto certo di riuscire a provare l'innocenza del suo cliente",
        "capo": "Non spetta a me decidere: in una situazione del genere bisogna chiedere al capo cosa è meglio fare",
        "collega": "Quella laggiù è la mia collega: lavoro con lei ormai da 10 anni e condividiamo lo stesso ufficio",
        "dottore": "La bambina ha la febbre molto alta: chiama il dottore e vedi se può venire a visitarla",
        "giudice": "il giudice ha ritenuto l'imputato colpevole del reato e lo ha condannato a 14 anni di reclusione",
        "lavorare": "Il laboratorio artistico propone corsi rivolti ai ragazzi delle scuole medie e superiori per imparare a lavorare la creta e creare semplici oggetti con essa.",
        "lavoro": "Alla mostra di fine anno saranno esposti i lavori che abbiamo realizzato sotto la guida dell’insegnante di tecnica."
    ]
}


#Preview {
    ContentView()
}
