//
//  ContentView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/09/23.
//

import SwiftUI
import WebKit

struct HomeView: View {
    
    

    @EnvironmentObject var coordinator: Coordinator
//    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfo>
//    @Environment(\.managedObjectContext) var moc
    @State private var enableButton = false
    @State private var showWebView = false
    
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
                
                
                Button(action: {
                    coordinator.goToGridView()
                }) {
                   Text("see your logs")
                }
                Spacer()
                HStack {
                    Text("powered by")
                        .font(.footnote)
                    Image("Spotify_Logo_RGB_Green")
                        .resizable()
//                        .frame(width: 155, height: 50)
                        .aspectRatio(3.3, contentMode: .fit)
                }
                .padding(.bottom, 36)
                .frame(width: 200)
            }
//            .padding(50)

                
                
                if showWebView {
                    ZStack {
                        WebView()
                            .ignoresSafeArea(.all)

                        
                    }
                    .onChange(of: webViewDelegate.tokenString) { newValue in
                        showWebView = false

                    }
                    .onChange(of: webViewDelegate.TokenActivitySign) { newValue in
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            Task {
                                try await APIService.shared.list = APIService.shared.getRecentlyListened()
                                try await APIService.shared.genres = APIService.shared.getRecentlyPlayedGenres()
                                print(APIService.shared.dict)
                                coordinator.goToTodaysResultsView()
                            }
                            
                        
                    }
                
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
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


