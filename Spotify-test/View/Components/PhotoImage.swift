//
//  DayImage.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 09/11/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoImage: View {
    @FetchRequest(sortDescriptors: []) var daysInfo: FetchedResults<DayInfo>
    @Environment(\.managedObjectContext) var moc
    
    
    let imageState: PhotoModel.ImageState
    let color: UIColor

    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable().scaledToFill()
                .frame(width: 300, height: 400)
                .onAppear {
//                    let uiImg = UIImage(image)
//                    SavedImage.shared.inputImage = uiImg
        

                }

        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 40))
                .foregroundColor(Color(color))
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct RoundedRectDayImage: View {
    let imageState: PhotoModel.ImageState
    let color: UIColor
    var body: some View {
        PhotoImage(imageState: imageState, color: color)
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerSize: (CGSize(width: 20, height: 30))))
            .frame(width: 300, height: 400)
            .background {
                RoundedRectangle(cornerSize: (CGSize(width: 20, height: 30))).fill(
                    LinearGradient(
                        colors: [.clear, .white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

struct EditableRoundedRectDayImage: View {
    @ObservedObject var photosManager: PhotoModel
    var color: UIColor
    
    var body: some View {
        
        ZStack {
            RoundedRectDayImage(imageState: photosManager.imageState, color: color)
            PhotosPicker(selection: $photosManager.imageSelection,
                         matching: .images,
                         photoLibrary: .shared()) {
                
                    
                    switch photosManager.imageState {
                    case .empty:
                        VStack {
                        Text(NSLocalizedString("select-img", comment: ""))
                            .font(.system(size: 14))
                            .foregroundColor(Color(color))
                            .padding(.top, 100)
                        }
                        .frame(width: 300, height: 400)
                
                    default:
                        VStack {
                            Spacer()

                        }
                        .frame(width: 300, height: 400)

                    
                    }
                    
               

                
            }
            .buttonStyle(.borderless)
        }
        .frame(width: 300, height: 400)

    }
}
