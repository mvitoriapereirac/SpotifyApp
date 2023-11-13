//
//  ContentView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/09/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    
//    @State private var token = UserDefaults.standard.value(forKey: "Authorization")
    @EnvironmentObject var coordinator: Coordinator
    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfo>
    @Environment(\.managedObjectContext) var moc
    @State private var songs: [String] = []
    let artist = "a"
    @State private var enableButton = false
    @State private var showWebView = false
    
    @ObservedObject var webViewDelegate = WebViewNavDelegate.shared
    @ObservedObject var dailyLogManager = DailyLogManager.shared
    
    var body: some View {
        ZStack {
            

                Button(action: {
//                    dailyLogManager.AllowLogButtonIfNeeded() { success in
//                        showWebView = success
//                        print(success)
//                    }
//                    if dailyLogManager.shouldRefresh {
                        showWebView = true
//
//                    }
                    
                })
                {
                    Text(dailyLogManager.shouldRefresh ? "toque aqui para comecar" : "ainda não está na hora")
                }
                
                if showWebView {
                    ZStack {
                        WebView()
                            .ignoresSafeArea(.all)

                        
                    }
                    .onChange(of: webViewDelegate.tokenString) { newValue in
                        showWebView = false

                    }
                    .onChange(of: webViewDelegate.TokenActivitySign) { newValue in
//                        DispatchQueue.main.async {
//                            APIService.shared.getNameAndURLStrings()
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
//                                coordinator.goToTodaysResultsView()
//
//
//                                                                }
//                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            Task {
                                try await APIService.shared.list = APIService.shared.getRecentlyListened()
                    //
                                
                                try await APIService.shared.genres = APIService.shared.getRecentlyPlayedGenres()
                                print("********")

                                print(APIService.shared.dict)
                                coordinator.goToTodaysResultsView()
                            }
//                            print("//////")
//                            print(webViewDelegate.TokenActivitySign)
////                            if webViewDelegate.isTokenReady == true {
//                                print("passei aq")
//                                DispatchQueue.main.async {
//                                    APIService.shared.getNameAndURLStrings()
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                                        coordinator.goToTodaysResultsView()
//
//                            }
//                        }
                        
                    }
                  
                    
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                            print("//////")
//                            print(webViewDelegate.isTokenReady)
//                            if webViewDelegate.isTokenReady == true {
//                                print("passei aq")
//                                DispatchQueue.main.async {
//                                    APIService.shared.getNameAndURLStrings()
//                                }
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                                    timeIsUp = true
//
//                                }
//                            }
//                        }
//
                    }
                    
                            
                        
                }
                
            }
        .onAppear {
            dailyLogManager.AllowLogButtonIfNeeded { success in
                enableButton = dailyLogManager.shouldRefresh
            }
        }
        
        .ignoresSafeArea(.all)

            
            
        }
//        .background(Color(UIColor.blend(color1: .yellow, intensity1: 0.3, color2: .systemPink, intensity2: 0.7)))
    
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
    
    func updateUIView(_ uiView: WKWebView, context: Context)  {
        if !WebViewNavDelegate.shared.tokenString.isEmpty {
            uiView.isHidden = true
        }
    }
}

class WebViewNavDelegate: NSObject, WKNavigationDelegate, ObservableObject {
    static let shared = WebViewNavDelegate()
    var tokenString = ""
    @Published var TokenActivitySign = false
    var iterator = 0
    var isFirstLogin = true
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        guard let urlString = webView.url?.absoluteString else { return }
        print(urlString)

        
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
            TokenActivitySign.toggle()
          

            
        }
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if ((webView.url?.absoluteString.contains("google")) != nil) {
            webView.isHidden = true 
        }
        
//        if isFirstLogin {
//            if iterator > 0 {
//                if ((webView.url?.absoluteString.contains("google")) != nil) {
////                    if !tokenString.isEmpty {
//                                        webView.isHidden = true
//                                        isFirstLogin = false
//                    //                }
//                }
////
//
//            }
//            iterator += 1
//
//        } else {
//            webView.isHidden = true
//
//        }
            

//        }
//        if iterator > 0 {
//            isFirstLogin = false
//            webView.isHidden = true
//
//        }
//        iterator += 1

    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog("Erro de navegacao: \(error.localizedDescription)")
    }

    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


