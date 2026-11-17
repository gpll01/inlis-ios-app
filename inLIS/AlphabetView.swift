import SwiftUI

struct AlphabetView: View {
    @State private var collapsed = false
    @State private var navigateToLexeme: Int? = nil
    
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { String($0) }
    
    var body: some View {
        ScrollView {
            // Tracker per lo scroll, come in DictionaryListView
            GeometryReader { geo in
                Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                       value: geo.frame(in: .named("alphaScroll")).minY)
            }
            .frame(height: 0)
            
            VStack(alignment: .leading, spacing: 20) {
                Spacer(minLength: 30)
                
                // SectionView rimane identica
                SectionView(title: "", words: letters)
                    .padding(.top, -10)
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .coordinateSpace(name: "alphaScroll")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            withAnimation(.easeInOut(duration: 0.15)) {
                collapsed = (value < -20)
            }
        }
        .navigationTitle(collapsed ? "alphabet" : "Alphabet")
        .navigationBarTitleDisplayMode(.large)
        .scrollIndicators(.hidden)
        .background(Color(hex:"F8E5D5").ignoresSafeArea()) // beige background
    }
}


#Preview {
    NavigationStack {
        AlphabetView()
    }
}
