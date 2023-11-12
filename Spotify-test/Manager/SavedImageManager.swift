//
//  SavedImage.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 11/11/23.
//

import Foundation
import SwiftUI

class SavedImage: ObservableObject {
    
    static let shared: SavedImage = SavedImage()
    @Published var inputImage: UIImage?
    
    func convertUIImageToDataType() -> Data? {
        let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)
        return pickedImage

    }
    
    func convertDataToUIImageType(data: Data?) -> UIImage? {
        let uiImage = UIImage(data: data ?? Data())
        return uiImage
        
    }
    
    
}
