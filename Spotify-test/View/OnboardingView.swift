//
//  OnboardingView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 15/11/23.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @State private var showLogo = false
    @State private var showWelcome = false
    @State private var showAboutPopup = false
    @State private var expandPopupWidth = false
    @State private var showIntro = false
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        ZStack {
            
            VStack(spacing: 15) {
                    Spacer()
                    if showLogo {
                        Image("MusicMood")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .shadow(radius: 18, y: 12)
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                    showWelcome = true
                                })
                                
                            }
                    }
                    if showWelcome {
                        Text("Seu diário afetivo")
                            .foregroundColor(.white)
                            .font(.title3.italic())
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
                                    showAboutPopup = true
                                })
                                
                            }
                    }
                
                    
                Spacer()
                }
                .animation(Animation.easeInOut(duration: 4).delay(1))

            if showAboutPopup {
                
                ZStack {
                    Color.white.cornerRadius(25)
                        .scaleEffect(x: expandPopupWidth ? 1 : 0, y: expandPopupWidth ? 1.2 : 0)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                                showIntro = true
                            })
                            
                        }

                    if showIntro {
                        VStack {
                            HStack {
                                Text(" Boas vindas")
                                    .font(.title3.bold().italic())
                                    .padding()
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.pink)
                                    
                                Spacer()
                            }
                            

                            Capsule()
                                .frame(width: 280, height: 2)
                                .foregroundColor(Color(.purple))
                            Spacer()
                            Text("MusicMood é um aplicativo que te ajuda a **viver intencionalmente**. \n \n Sabe quando nem você sabe o que sente? É aí que te ajudo! As músicas que você escuta no cotidiano podem contar uma bela história sobre quem você é. \n \n Que tal se aventurar numa jornada de autodescoberta? \n\n Para uma melhor experiência, por favor **autorize o envio de notificações do MusicMood** para seu dispositivo!")
                                .font(.body.italic())
                                .padding(.bottom, 16)
                                .padding(.horizontal, 16)
                            
                            Button(action: {
                                NotificationManager.shared.requestAuthorization()
                                coordinator.goToHomePage()
                            }){
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 20, height: 30)
                                    .foregroundColor(Color(.purple))
                            }
                        }

                    }

                }
                
                .padding(.horizontal, 36)
                .padding(.vertical, 170)
                .onAppear {
                    expandPopupWidth.toggle()
                }
                .animation(Animation.easeInOut(duration: 1).delay(1))

            }
            
        }
        .background(.black).ignoresSafeArea(.all)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            showLogo = true
            })

        }
    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
