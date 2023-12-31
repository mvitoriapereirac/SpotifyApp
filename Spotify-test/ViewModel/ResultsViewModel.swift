//
//  Rectangle.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 24/10/23.
//

import Foundation
import SwiftUI
import CoreData
import Photos
import PhotosUI
import CoreTransferable


class ResultsViewModel: ObservableObject {
    @Published var apiService = APIService.shared
    @Published var genres: [[String]] = [[]]
    @Published var genresAmountDict: [String : Double] = [:]
    var total = 0.0
    @Published var current: [Double]
    @Published var currentColor: [ UIColor ] = []
    @Published var weekday = Calendar.current.component(.weekday, from: Date())
    @Published var day = Calendar.current.component(.day, from: Date())
    @Published var month = Calendar.current.component(.month, from: Date())
    @Published var color: UIColor?
    var double: Double = 0.0
    let weekDays = [NSLocalizedString("sunday-3", comment: ""): 1, NSLocalizedString("monday-3", comment: ""): 2, NSLocalizedString("tuesday-3", comment: ""): 3, NSLocalizedString("wednesday-3", comment: ""): 4, NSLocalizedString("thursday-3", comment: ""): 5, NSLocalizedString("friday-3", comment: ""): 6, NSLocalizedString("saturday-3", comment: ""): 7]
    
    
    var bright: Mood {
        let mainMoods = MainMoods()
        return mainMoods.bright
    }
    
    var dark: Mood {
        let mainMoods = MainMoods()
        return mainMoods.dark
    }
    
    var fun: Mood {
        let mainMoods = MainMoods()
        return mainMoods.fun
    }
    
    var soft: Mood {
        let mainMoods = MainMoods()
        return mainMoods.soft
    }
    
    init(apiService: APIService = APIService.shared, genres: [[String]], genresAmountDict: [String : Double], total: Double = 0.0, current: [ Double]) {
        self.apiService = apiService
        self.genres = genres
        self.genresAmountDict = genresAmountDict
        self.total = total
        self.current = current
        genresArray()
        
    }
    
    func genresArray() {
        genres = apiService.genres
        
        //        print(weekday)
        //        print(genres)
        //        print(genres.count)
        print(countGenres(genre: "pop"))
        makeGenresAmountDict()
        
        
    }
    
    
    func countGenres(genre: String) -> Double {
        var tracks = 0.0
        for i in genres {
            for g in i {
                if g.contains(genre) {
                    tracks += 1
                    break
                }
            }
            
        }
        return tracks
    }
    
    func makeGenresAmountDict() {
        var aux = 0.0
        
        
        for i in bright.genres {
            
            if aux == 0 {
                aux = countGenres(genre: i)
            } else {
                aux += countGenres(genre: i)
            }
            
            
        }
        genresAmountDict.updateValue(aux, forKey: bright.mood)
        aux = 0
        
        for j in dark.genres {
            
            if aux == 0 {
                aux = countGenres(genre: j)
            } else {
                aux += countGenres(genre: j)
            }
            
        }
        genresAmountDict.updateValue(aux, forKey: dark.mood)
        aux = 0
        
        
        
        for k in fun.genres {
            if aux == 0 {
                aux = countGenres(genre: k)
            } else {
                aux += countGenres(genre: k)
            }
        }
        genresAmountDict.updateValue(aux, forKey: fun.mood)
        aux = 0
        
        for l in soft.genres {
            if aux == 0 {
                aux = countGenres(genre: l)
            } else {
                aux += countGenres(genre: l)
            }
        }
        genresAmountDict.updateValue(aux, forKey: soft.mood)
        aux = 0
        
        
        print(genresAmountDict)
        makeGenresAmountStats()
    }
    
    func makeGenresAmountStats() {
        
        let brightAmount = genresAmountDict[bright.mood]!
        print(brightAmount)
        let darkAmount = genresAmountDict[dark.mood]!
        let funAmount = genresAmountDict[fun.mood]!
        let softAmount = genresAmountDict[soft.mood]!
        
        total = brightAmount + darkAmount + funAmount + softAmount
        print(total)
        let brightCoef = brightAmount / total
        print(brightCoef)
        let darkCoef = darkAmount / total
        let funCoef = funAmount / total
        let softCoef = softAmount / total
        currentColor = [bright.color, dark.color, fun.color, soft.color]
        current = [brightCoef, darkCoef, funCoef, softCoef]
        print("current:")
        print(current)
        
        
        
    }
    
    func makeUIColorBlend() -> UIColor {
        if !currentColor.isEmpty {
            let color = UIColor.blend(color1: self.currentColor[0], intensity1: self.current[0], color2: self.currentColor[1], intensity2: self.current[1], color3: self.currentColor[2], intensity3: self.current[2], color4: self.currentColor[3], intensity4: self.current[3])
            return color
            
        }
        
        return UIColor()
    }
    
    func makeDateString(day: Int, month: Int, weekday: Int) -> String {
        print(weekday)
        var dayName = ""
        for i in weekDays {
            if i.value == weekday {
                dayName = i.key
            }
        }
        print(dayName + ", " + String(day) + "/" + String(month))
        return dayName + ", " + String(day) + "/" + String(month)
        
    }
    
}








