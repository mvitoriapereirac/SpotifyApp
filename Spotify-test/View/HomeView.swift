//
//  ContentView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/09/23.
//

import SwiftUI
import WebKit

//TO DO: refactor code in order to create a viewmodel for this view
struct HomeView: View {
    
    
    
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var enableButton = false
    @State private var showWebView = false
    @State private var showLoadingPopup = false
    @State private var showLoadingBar = false
    
    @ObservedObject var webViewDelegate = WebViewNavDelegate.shared
    @ObservedObject var dailyLogManager = DailyLogManager.shared
    

    
    var body: some View {
        ZStack {
            VStack() {
                Spacer()
                Image("MusicMood")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .shadow(radius: 18, y: 12)
                
                VStack(spacing: 40) {
                    Button(action: {
                        if dailyLogManager.shouldRefresh {
                            showWebView = true
                            
                        }
                        
                    })
                    {
                        Text(dailyLogManager.shouldRefresh ? "allow-button" : "deny-button")
                    }
                    .buttonStyle(dailyLogManager.shouldRefresh ? .neumorphicPurple : .neumorphicGray)
                    
                    
                    Button(action: {
                        coordinator.goToGridView()
                    }) {
                        Text("see-your-journal")
                            .foregroundColor(Color(.purple))
                            .font(.headline.bold())
                    }
                }
                Spacer()
                HStack {
                    Text("powered by")
                        .font(.footnote)
                    Image("Spotify_Logo_RGB_Green")
                        .resizable()
                        .aspectRatio(3.3, contentMode: .fit)
                }
                .padding(.bottom, 36)
                .frame(width: 200)
            }
            
            
            
            
//            ZStack {
                
                if showLoadingPopup {
                    Color(.black).opacity(0.4).ignoresSafeArea(.all)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                showLoadingBar = true
                            })
                        }
                    
                    if showLoadingBar {
                        VStack {
                            LoadingBar()
                            Text("loading-text")
                                .font(.headline)
                                .foregroundColor(.black)
                                .onAppear {
                                    dailyLogManager.shouldRefresh = false
                                }
                            
                        }
                        .padding(.horizontal, 60)
                        .padding(.vertical, 240)
                        .background(Color.white.cornerRadius(25))
                    }
                    
                    
                }
                
                if showWebView {
                    WebView()
                        .ignoresSafeArea(.all)
                        .onAppear{
                            showLoadingPopup = true
                            
                        }
                    
                }
                
//            }
            
            
            
            
            
        }
        .onChange(of: webViewDelegate.tokenString) { newValue in
            showWebView = false
            
        }
        .onChange(of: webViewDelegate.TokenActivitySign) { newValue in
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                Task {
                    try await APIService.shared.getRecentlyListened()
                    try await APIService.shared.getRecentlyPlayedGenres()
                    showWebView = false
                    showLoadingPopup = false
                    coordinator.goToTodaysResultsView()
                }
                
                
            }
            
        }
        .background(Color.projectWhite)
        
        .onAppear {
            
            dailyLogManager.AllowLogButtonIfNeeded { success in
                enableButton = dailyLogManager.shouldRefresh
                NotificationManager.shared.scheduleNotifications()

            }
        }
        
        .ignoresSafeArea(.all)
        
        
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


