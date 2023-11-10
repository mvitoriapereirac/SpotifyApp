//
//  TodayResultsView.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 28/10/23.
//

import Foundation
import SwiftUI
import Photos
import PhotosUI

struct ResultsView: View {
    @ObservedObject private var viewModel = ResultsViewModel(genres: [[]], genresAmountDict: [:], current: [])
    @EnvironmentObject var coordinator: Coordinator
    let isFirstVisitToday: Bool
    let logManager = DailyLogManager.shared
    //    let selectedDayColor = UserDefaults.standard.value(forKey: "SelectedDayColor")
    let dayFromSelected: Int?
    let monthFromSelected: Int?
    let weekdayFromSelected: Int?
    let colorFromSelected: UIColor?
    let dayInfo: FetchedResults<DayInfo>.Element?
    @State private var userInput = ""
    @FocusState var textFieldIsFocused: Bool
    
    
    var currentPercentage: [Double] {
        if let currentValues = dayInfo?.current as? [Double] {
            return currentValues
        }
        return []
    }
    
    var chosenColor: UIColor {
        if let currentColor = dayInfo?.color as? UIColor {
            return currentColor
        }
        
        return UIColor()
    }
    
//    var chosenPic: UIImage {
//        if let currentPic = dayInfo?.chosenPic as? UIImage {
//            return currentPic
//        }
//        return UIImage()
//    }
    
    
    init(viewModel: ResultsViewModel = ResultsViewModel(genres: [[]], genresAmountDict: [:], current: []), isFirstVisitToday: Bool, dayFromSelected: Int? = nil, monthFromSelected: Int? = nil, weekdayFromSelected: Int? = nil, colorFromSelected: UIColor? = nil, dayInfo: FetchedResults<DayInfo>.Element? = nil) {
        self.viewModel = viewModel
        self.isFirstVisitToday = isFirstVisitToday
        self.dayFromSelected = dayFromSelected
        self.monthFromSelected = monthFromSelected
        self.weekdayFromSelected = weekdayFromSelected
        self.colorFromSelected = colorFromSelected
        self.dayInfo = dayInfo
    }
    
    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfo>
    @Environment(\.managedObjectContext) var moc
    @State var showGrid = false
    @StateObject var photosManager = PhotoModel()
    
    
    var body: some View {
        //        ZStack {
        ZStack(alignment: .trailing) {
            Color(isFirstVisitToday ? (viewModel.makeUIColorBlend()) : (chosenColor))
                .ignoresSafeArea()
            
                VStack {
                    ZStack {
                        Color(.white)
                            .opacity(0.9)
                            .cornerRadius(25.0)
                            .padding(.top, 100)
                            .padding(.horizontal, 8)
                        ScrollView {

                        VStack{
                                
                                FlowerAnimation(color: isFirstVisitToday ? Color(viewModel.makeUIColorBlend()) : Color(chosenColor))
                                .padding(.vertical, 100)

                                Text("Cor do dia")
                                    .foregroundColor(.black)
                                    .font(.subheadline.bold())
                                    .padding(8)
 
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Seus resultados")
                                            .foregroundColor(.black)
                                            .font(.subheadline.bold())
                                        
                                        
                                        
                                        if !isFirstVisitToday {
                                            HStack {
                                                DailyStats(arrayValues: currentPercentage, arrayColors: viewModel.currentColor)
                                                
                                            }
                                            
                                            
                                        } else {
                                            HStack {
                                                
                                                DailyStats(arrayValues: viewModel.current, arrayColors: viewModel.currentColor)
                                                
                                            }
                                      
                                        }
                                        
                                        
                                    }
                                    Spacer()
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                                .padding()
                                .background(RoundedRectangle(cornerSize: CGSize(width: 7, height: 7)).stroke().foregroundColor(.white).padding(8))
                                
                                
                                    VStack (alignment: .leading, spacing: 8) {
                                        MoodCaption(color: .projectBlack)
                                            .padding(8)
                                            .padding(.bottom, 36)
                                        HStack {
                                            Image("comma")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        
                                        VStack {
                                            
                                            if isFirstVisitToday {
                                                TextField("", text: $userInput, prompt: Text("Em que pensei enquanto ouvi música hoje?").foregroundColor(.black), axis: .vertical)
                                                    .textFieldStyle(.plain)
                                                    .foregroundColor(.black)
                                                    .disableAutocorrection(true)
                                                    .padding(.horizontal, 16)
                                                    .focused($textFieldIsFocused)
                                                    .toolbar { // when the axis parameter (enabling multiline text) is added, we lose the ability to dismiss the keyboard. this being the case, adding a "done" button is a user friendly alternative
                                                        ToolbarItemGroup(placement: .keyboard) {
                                                            Spacer()
                                                            Button("Done") {
                                                                textFieldIsFocused = false
                                                            }
                                                        }
                                                    }

                                            } else {
                                                Text((dayInfo?.dayMessage)!)
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal, 16)
                                            }

                                                                                      
                                        }
                       
                                        Spacer(minLength: 24)
                                        
                                        HStack {
                                            Image(systemName: "photo.on.rectangle.angled")
                                                .resizable()
                                                .foregroundColor(.black)
                                                .frame(width: 30, height: 25)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Spacer()
                                            if isFirstVisitToday {
                                                EditableCircularProfileImage(photosManager: photosManager, color: isFirstVisitToday ? viewModel.makeUIColorBlend() : chosenColor)
                                            } else {
//                                                Image(uiImage: chosenPic)
//                                                    .frame(width: 300, height: 400)
                                            }
                                            Spacer()
                                            
                                        }
                                        .padding()
                                        
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                if isFirstVisitToday {
                                                    viewModel.genresArray()
                                                    
                                                    print(logManager.daysOfAbsence)
                                                    if logManager.daysOfAbsence.count != 0 {
                                                        print("michael jackson")
                                                        print(logManager.daysOfAbsence.count)
                                                        
                                                        for _ in logManager.daysOfAbsence {
                                                            let dayInfo = DayInfo(context: moc)
                                                            //                        dayInfo.weekday = Int16(viewModel.weekday)
                                                            //                        dayInfo.day = Int16(viewModel.day)
                                                            //                        dayInfo.month = Int16(viewModel.month)
                                                            
                                                            dayInfo.color = UIColor.clear
                                                            try? moc.save()
                                                            
                                                        }
                                                    }
                                                    
                                                    let dayInfo = DayInfo(context: moc)
                                                    dayInfo.dayMessage = self.userInput
//                                                    dayInfo.chosenPic = photosManager.imageSelection as Data
                                                    dayInfo.weekday = Int16(viewModel.weekday)
                                                    dayInfo.color = viewModel.makeUIColorBlend()
                                                    dayInfo.day = Int16(viewModel.day)
                                                    dayInfo.month = Int16(viewModel.month)
                                                    dayInfo.current = viewModel.current as NSObject
                                                    try? moc.save()
                                                }

                                                coordinator.goToGridView()
                                            }) {
                                                Text("seus registros")
                                            }
                                            .buttonStyle(NeumorphicButtonStyle(bgColor: isFirstVisitToday ? Color(viewModel.makeUIColorBlend()) : Color(chosenColor)))

                                            Spacer()
                                            
                                        }
                                        .padding()
                                        

                                        
                                        
                                    }

                                }
                                
                

                        }
                        
                        
                        
                        .padding(.top, 100)
                        .padding(.leading, 4)
                        .padding(.trailing, 2)

                    }
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .KeyboardAwarePadding(background: .clear.opacity(0.9))

            }
            
            
            
            
            
        }

        
        .overlay(
            VStack(alignment: .trailing) {
                Text(viewModel.makeDateString(day: isFirstVisitToday ? viewModel.day : Int(dayInfo!.day), month: isFirstVisitToday ? viewModel.month : Int(dayInfo!.month), weekday: isFirstVisitToday ? viewModel.weekday : Int(dayInfo!.weekday)))
                    .foregroundColor(.white)
                    .padding(.top, 65)
                    .font(.headline.bold())
                Spacer()
            }
            
        )
        .ignoresSafeArea(.all)
        .onAppear {
            
            
            
            
        }
        
    }
}

