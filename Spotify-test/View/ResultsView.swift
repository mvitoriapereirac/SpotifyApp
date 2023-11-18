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

//TO DO: move data storage with Core Data to some other structure more adequate to MVVM architecture than a view (https://medium.com/@santiagogarciasantos/core-data-and-swiftui-a-solution-c0404a01c1aa)


struct ResultsView: View {
    @ObservedObject private var viewModel = ResultsViewModel(genres: [[]], genresAmountDict: [:], current: [])
    @EnvironmentObject var coordinator: Coordinator
    let isFirstVisitToday: Bool
    let logManager = DailyLogManager.shared
    let dayInfo: FetchedResults<DayInfo>.Element?
    @State private var userInput: String = ""
    @FocusState var textFieldIsFocused: Bool
    @ObservedObject var savedImg = SavedImage.shared
    
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
    
    var chosenPic: UIImage {
        
        return SavedImage.shared.convertDataToUIImageType(data: dayInfo?.chosenPic) ?? UIImage(named: "placeholder")!
        
    }
    
    var chosenMessage: String {
        if let message = dayInfo?.dayMessage as? String {
            if message != ""{
                return message
            }
        }
        return NSLocalizedString("thoughts-placeholder", comment: "")
    }
    
    
    
    
    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfo>
    @Environment(\.managedObjectContext) var moc
    @State var showGrid = false
    @StateObject var photosManager = PhotoModel()
    
    init(viewModel: ResultsViewModel = ResultsViewModel(genres: [[]], genresAmountDict: [:], current: []), isFirstVisitToday: Bool, dayInfo: FetchedResults<DayInfo>.Element? = nil) {
        self.viewModel = viewModel
        self.isFirstVisitToday = isFirstVisitToday
        self.dayInfo = dayInfo
    }
    
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
                        .padding(.top, 110)
                        .padding(.horizontal, 8)
                    ScrollView {
                        
                        VStack{
                            
                            FlowerAnimation(color: isFirstVisitToday ? Color(viewModel.makeUIColorBlend()) : Color(chosenColor))
                                .padding(.vertical, 30)
                            
                            Text("color-blending")
                                .foregroundColor(.black)
                                .font(.subheadline)
                                .padding(.all, 16)
                            
                            VStack(alignment: .leading, spacing: 25) {
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("your-results")
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
                                    Spacer(minLength: 0)
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                                .padding()
                                .background(RoundedRectangle(cornerSize: CGSize(width: 7, height: 7)).stroke().foregroundColor(.white).padding(8))
                                
                                
                                VStack (alignment: .leading, spacing: 8) {
                                    MoodCaption(color: .black)
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
                                            TextField("", text: $userInput, prompt: Text("thoughts-input").foregroundColor(isFirstVisitToday ? Color(viewModel.makeUIColorBlend()) : Color(chosenColor)), axis: .vertical)
                                                .extensionTextFieldView(roundedCornes: 8, startColor: .clear, endColor: .white, textColor: isFirstVisitToday ? Color(viewModel.makeUIColorBlend()) : Color(chosenColor))
                                                .foregroundColor(.black)
                                                .disableAutocorrection(true)
                                                .padding(.horizontal, 16)
                                                .focused($textFieldIsFocused)
                                                .toolbar {
                                                    // when the axis parameter (enabling multiline text) is added, we lose the ability to dismiss the keyboard. this being the case, adding a "done" button is a user friendly alternative
                                                    ToolbarItemGroup(placement: .keyboard) {
                                                        Spacer()
                                                        Button("Done") {
                                                            textFieldIsFocused = false
                                                        }
                                                    }
                                                }
                                            
                                        } else {
                                            Text(chosenMessage)
                                                .font(.body.italic())
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
                                            EditableRoundedRectDayImage(photosManager: photosManager, color: isFirstVisitToday ? viewModel.makeUIColorBlend() : chosenColor)
                                        } else {
                                            Image(uiImage: chosenPic)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 300, height: 400)
                                                .cornerRadius(25)
                                        }
                                        Spacer()
                                        
                                    }
                                    .padding()
                                    
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            if isFirstVisitToday {
                                                viewModel.genresArray()
                                                
                                                if logManager.daysOfAbsence.count != 0 {
                                                    
                                                    for _ in logManager.daysOfAbsence {
                                                        let dayInfo = DayInfo(context: moc)
                                                        dayInfo.color = UIColor.clear
                                                        try? moc.save()
                                                        
                                                    }
                                                }
                                                
                                                let dayInfo = DayInfo(context: moc)
                                                dayInfo.dayMessage = self.userInput
                                                dayInfo.chosenPic = savedImg.convertUIImageToDataType()
                                                dayInfo.weekday = Int16(viewModel.weekday)
                                                dayInfo.color = viewModel.makeUIColorBlend()
                                                dayInfo.day = Int16(viewModel.day)
                                                dayInfo.month = Int16(viewModel.month)
                                                dayInfo.current = viewModel.current as NSObject
                                                try? moc.save()
                                            }
                                                coordinator.goToGridView()
                                                
                                            
                                        }) {
                                            Text("your-registers")
                                        }
                                        .buttonStyle(NeumorphicButtonStyle(bgColor: isFirstVisitToday ? Color(viewModel.makeUIColorBlend()) : Color(chosenColor)))
                                        .padding()
                                        
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
                    .padding(.top, 112)
                    
                    
                    
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
        
        
    }
}

