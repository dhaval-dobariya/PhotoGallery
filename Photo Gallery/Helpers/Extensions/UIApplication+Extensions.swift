//
//  UIApplication+Extensions.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import UIKit

// MARK: UIApplication extensions
extension UIApplication {
    
    /// To get top most view controller object
    /// - Parameter base: UIViewController optional - p
    class func getTopViewController(base: UIViewController? = nil) -> UIViewController? {
        if let topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            return topController
        } else {
            let base = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }?.rootViewController
            
            if let nav = base as? UINavigationController {
                return getTopViewController(base: nav.visibleViewController)
                
            } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
                
            }
            else if let presented = base?.presentedViewController {
                return getTopViewController(base: presented)
            }
            return base            
        }
    }
}
