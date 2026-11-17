//
//  WelcomeView.swift
//  InLIS2
//
//  Created by Vincenzo Russo on 16/10/25.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var data: AppData
    let onContinue: () -> Void

    // Durata del caricamento: 1.5 secondi
    private let loadingDuration: TimeInterval = 1.5

    init(onContinue: @escaping () -> Void) {
        self.onContinue = onContinue
    }

    var body: some View {
        ZStack {
            Color(hex: "0095B6")
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.9), lineWidth: 3)
                    )
                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)

                Text("Welcome")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Spacer()
                Spacer()
            }
            .padding()
        }
        .onAppear {
            // Dopo 1.5s prosegui automaticamente alla PathView
            DispatchQueue.main.asyncAfter(deadline: .now() + loadingDuration) {
                onContinue()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView { }
            .environmentObject(AppData())
    }
}
