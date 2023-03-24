//
//  UIAplication+Ext.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 24.03.2023.
//

import UIKit

extension UIViewController {
    var topMostViewController : UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController ?? tab
        }
        
        return self
    }
}

extension UIApplication {
    var topMostViewController : UIViewController? {
        return UIWindow.key?.rootViewController?.topMostViewController
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
