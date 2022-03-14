//
//  GalleryViewModel.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import UIKit

class GalleryViewModel: NSObject {

    var photos: [Photo]?
    
    /// To get gallery photos and other details related to gallery
    /// - Parameter successBlock: CompletionBlock for success
    func fetchGallery(successBlock: @escaping() -> Void) {
        ServiceManager.shared.performRequest(withAPIName: Constants.URL.GetPhotos, method: .get) { [weak self] response in
            do {
                self?.photos = try JSONDecoder().decode([Photo].self, from: response)
                successBlock()
            } catch {
                print("error in json parsing: " + error.localizedDescription)
                if let topController = UIApplication.getTopViewController(base: nil) {
                    Utilities.showAlert(message: error.localizedDescription, viewController: topController, completion: nil)
                }
            }
        } errorBlock: { message in
            if let controller = UIApplication.getTopViewController(base: nil) {
                Utilities.showAlert(message: message, viewController: controller, completion: nil)
            }
        }

    }
}
