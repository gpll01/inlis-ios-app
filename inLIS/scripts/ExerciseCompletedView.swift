//
//  ExerciseCompletedView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

// ExerciseCompletedView.swift
// Schermata finale con anello di progresso e bottoni Repeat / Next Exercise
import SwiftUI

// Local color constants to match the app palette.
// Replace with your shared theme if you have one.
private let bgThemeColor = Color(hex: "F8E5D5")
private let brandAccentColor = Color(hex: "0095B6")


struct CompletedExerciseView: View {
    @State private var selectedTab: Int = 0

    // Optional: parameters if you navigate here with score/handlers
    var score: Int = 0
    var total: Int = 0
    var onRepeat: (() -> Void)? = nil
    var onNext: (() -> Void)? = nil

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Proper full-screen background that ignores safe areas
                bgThemeColor.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer().frame(height: 12)

                    Text("COMPLETED")
                        .font(.system(size: min(50, geo.size.width * 0.09), weight: .bold))
                        .foregroundColor(brandAccentColor)
                        .padding(.top, -5)

                    ActivityRingView(size: min(geo.size.width * 0.60, 340),
                                     progress: total > 0 ? CGFloat(score) / CGFloat(total) : 0.0,
                                     ringColor: brandAccentColor,
                                     innerCircleColor: bgThemeColor,
                                     innerSymbol: "hands.clap")
                        .padding(.top, 60)

                    if total > 0 {
                        Text("\(score) / \(total)")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color(hex: "0095B6"))
                            .padding(.top, 30)
                    }

                    Spacer()

                    VStack(spacing: 20) {
                        ActionPill(title: "REPEAT",
                                   width: geo.size.width * 0.62,
                                   height: 78,
                                   accentColor: brandAccentColor) {
                            onRepeat?()
                        }

                        ActionPill(title: "NEXT EXERCISE",
                                   width: geo.size.width * 0.62,
                                   height: 78,
                                   accentColor: brandAccentColor) {
                            onNext?()
                        }
                    }
                    .padding(.bottom, 55)

                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .preferredColorScheme(.light)
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationBarBackButtonHidden(true) // Nasconde il chevron indietro
        }
    }
}




struct ActionPill: View {
    var title: String
    var width: CGFloat
    var height: CGFloat
    var accentColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(Color.white)
                    .frame(width: width, height: height)
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 6)

                RoundedRectangle(cornerRadius: height / 2)
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: Color.white.opacity(0.98), location: 0),
                            .init(color: Color.white.opacity(0.94), location: 1)
                        ]), startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: width - 6, height: height - 6)

                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(accentColor)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct ActivityRingView: View {
    var size: CGFloat
    var progress: CGFloat = 1.0
    var ringColor: Color = Color.blue
    var innerCircleColor: Color = Color.white
    var innerSymbol: String = "hands.clap"
    var innerSymbolScale: CGFloat = 0.28

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: size * 0.12)
                .foregroundColor(ringColor)
                .opacity(0.12)

            Circle()
                .trim(from: 0, to: max(0, min(progress, 1)))
                .stroke(style: StrokeStyle(lineWidth: size * 0.12, lineCap: .butt))
                .rotationEffect(.degrees(-90))
                .foregroundColor(ringColor)

            
            Circle()
                .fill(innerCircleColor)
                .frame(width: size * 0.48, height: size * 0.48)

            Image(systemName: innerSymbol)
                .font(.system(size: size * innerSymbolScale, weight: .regular))
                .foregroundColor(ringColor)
        }
        .frame(width: size, height: size)
    }
}

struct CompletedExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedExerciseView()
    }
}
