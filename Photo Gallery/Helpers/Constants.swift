//
//  Constants.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import UIKit

/// Constatnts
class Constants: NSObject {

    /// URLs
    struct URL {
        static let BaseURL = "https://api.unsplash.com/"
        static let GetPhotos = "photos"
    }
    
    /// Messages
    struct Messages {
        static let commonErrorMessage = "Something went wrong, Please try again!"
        static let networkErrorMessage = "Network issue, Please check internet connectivity!"
    }
    
    /// UnSplash keys
    struct unsplash {
        static let AccessKey = "8d1KaQaMz56jbkupbvx-NmcIvDC3zyw1Crtwf5HaY8s"
        static let SecretKey = "KXzXFxEm8JGuFwodFSeKyqLdRKGiFQNNveOmGZeJBhg"
    }
}
