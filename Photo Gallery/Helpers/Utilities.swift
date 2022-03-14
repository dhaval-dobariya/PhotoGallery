//
//  Utilities.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import UIKit

/// Class for common utilities
class Utilities: NSObject {
    /// To show alert
    /// - Parameter title: alert title text
    /// - Parameter message: alert description / message text
    /// - Parameter viewController: parent view controller from where we want to show alert
    /// - Parameter completion: block which trigger when user dismiss/close the alert
    static func showAlert(withTitle title: String? = nil, message : String, viewController : UIViewController, completion:(() -> Void)?) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
            if let completion = completion {
                completion()
            }
        }
        alertView.addAction(cancelAction)
        viewController.present(alertView, animated: true, completion: nil)
    }
    
    static func getTextHeight(width: CGFloat, addExtraHeight: CGFloat, sourceString: String, font: UIFont) -> CGFloat {   
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = sourceString.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)//, .usesFontLeading
        return boundingBox.height + addExtraHeight
        
    }
}

