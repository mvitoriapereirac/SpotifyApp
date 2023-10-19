//
//  ContentView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/09/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
//    private func getAccessTokenFromWebView() -> WKWebView? {
//        guard let urlRequest = APIService.shared.getAccessTokenURL() else { return nil }
//        let webView = WKWebView()
//
//        webView.load(urlRequest)
//        return webView
        
//    }
    
    @State private var token = UserDefaults.standard.value(forKey: "Authorization")
    
    var body: some View {
        ZStack {
            
            if token != nil {
                Text("omg hi")
                    .foregroundColor(.black)
                    .onAppear {
                        print(token)
                        print("contentView")
                        Task {
                            let songs = try await APIService.shared.search()
                        }
                    }
                
                
            } else {
                WebView()
                    .ignoresSafeArea(.all)
            }
//
           
                
        }
    }
}

struct WebView: UIViewRepresentable {
    
    private func getAccessTokenFromWebView() -> WKWebView? {
        guard let urlRequest = APIService.shared.getAccessTokenURL() else { return nil }
        let webView = WKWebView()
        
        webView.load(urlRequest)
        webView.navigationDelegate = WebViewNavDelegate.shared
        return webView
        
    }
    

    func makeUIView(context: Context) -> WKWebView {
        return getAccessTokenFromWebView() ?? WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

class WebViewNavDelegate: NSObject, WKNavigationDelegate {
    static let shared = WebViewNavDelegate()
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else { return }
        print(urlString)
        
        var tokenString = ""
        if urlString.contains("#access_token=") {
            let range = urlString.range(of:"#access_token=")
            guard let index = range?.upperBound else { return }
            
            tokenString = String(urlString[index...])
        }
        
        if !tokenString.isEmpty {
            let range = tokenString.range(of: "&token_type=Bearer")
            guard let index = range?.lowerBound else { return }
            
            tokenString = String(tokenString[..<index])
            print(tokenString)
            
            UserDefaults.standard.setValue(tokenString, forKey: "Authorization")
            webView.removeFromSuperview()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
