//
//  Delegate.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 11/11/23.
//

import Foundation
import SwiftUI
import WebKit

class WebViewNavDelegate: NSObject, WKNavigationDelegate, ObservableObject {
    static let shared = WebViewNavDelegate()
    var tokenString = ""
    @Published var TokenActivitySign = false

    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else { return }
        print("url string 1 \(urlString)")
    }
    

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        guard let urlString = webView.url?.absoluteString else { return }
        print("url string 2 \(urlString)")

        
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
        
        if tokenString != ""{
            if ((webView.url!.absoluteString.contains(tokenString))) {
                print(tokenString)
                webView.isHidden = true

            }
        }
        

    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog("Erro de navegacao: \(error.localizedDescription)")
    }

    
    
}
