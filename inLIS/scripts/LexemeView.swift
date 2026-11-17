import SwiftUI

struct LexemeView: View {
    let lexemes: [Lexeme]        // Array di tutte le lettere
    @State var selectedIndex: Int // Indice della lettera corrente
    
    private var currentLexeme: Lexeme {
        lexemes[selectedIndex]
    }

    private var isLetter: Bool {
        let lexeme = currentLexeme
        return lexeme.title.count == 1
    }

    var body: some View {
        ZStack {
            Color(hex: "F8E5D5").ignoresSafeArea()

            TabView(selection: $selectedIndex) {
                ForEach(lexemes.indices, id: \.self) { index in
                    let lexeme = lexemes[index]

                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(lexeme.title)
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color(red: 0/255, green: 149/255, blue: 182/255))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)

                            if isLetter {
                                Spacer().frame(height: 100)
                                Image(lexeme.mainGifName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 260)
                                    .cornerRadius(10)
                                    .clipped()
                                    .shadow(radius: 6)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                GIFView(gifName: lexeme.mainGifName)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 240)
                                    .cornerRadius(16)
                                    .shadow(radius: 6)

                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Example:")
                                        .font(.title3.bold())
                                        .foregroundColor(Color(red: 0/255, green: 149/255, blue: 182/255))

                                    GIFView(gifName: lexeme.exampleGifName)
                                        .frame(height: 220)
                                        .cornerRadius(14)
                                        .shadow(radius: 4)

                                    Text(lexeme.exampleCaption)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                }
                                .padding(.top, 8)
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 32)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

struct LexemeView_Previews: PreviewProvider {
    static var letters: [Lexeme] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map {
        Lexeme(title: String($0),
               mainGifName: "ita.alfabeto.\($0.lowercased())",
               exampleGifName: "",
               exampleCaption: "")
    }

    static var previews: some View {
        NavigationStack {
            LexemeView(lexemes: letters, selectedIndex: 0)
        }
    }
}
