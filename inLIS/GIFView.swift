//
//  GIFView.swift
//  InLIS
//
//  Created by Giusy Pellino on 16/10/25.
//

import SwiftUI
import WebKit

struct GIFView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear
        webView.isOpaque = false
        loadGIF(in: webView)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Ricarica la GIF se cambia nome
        loadGIF(in: uiView)
    }

    private func loadGIF(in webView: WKWebView) {
        if let path = Bundle.main.path(forResource: gifName, ofType: "gif") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                webView.load(
                    data,
                    mimeType: "image/gif",
                    characterEncodingName: "",
                    baseURL: URL(fileURLWithPath: path)
                )
            }
        }
    }
}
