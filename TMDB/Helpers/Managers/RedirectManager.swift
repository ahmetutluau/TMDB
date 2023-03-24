//
//  RedirectManager.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 23.03.2023.
//

import UIKit

class RedirectManager {
    typealias CompletionHandler = (() -> Void)
    static let shared = RedirectManager()
    private init() {}
    
    func showAlert(from: UIViewController?,
                   title: String? = nil,
                   message: String? = nil,
                   hasCancel: Bool? = false,
                   firstButtonTitle: String?,
                   secondButtonTitle: String? = nil,
                   thirdButtonTitle: String? = nil,
                   firstActionCompletion: CompletionHandler? = nil,
                   secondActionCompletion: CompletionHandler? = nil,
                   thirdActionCompletion: CompletionHandler? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: firstButtonTitle, style: .default, handler: { action in
            firstActionCompletion?()
        }))
        
        if let secondButtonTitle = secondButtonTitle {
            alert.addAction(UIAlertAction(title: secondButtonTitle, style: .default, handler: { action in
                secondActionCompletion?()
            }))
        }
        
        if let thirdButtonTitle = thirdButtonTitle {
            alert.addAction(UIAlertAction(title: thirdButtonTitle, style: .default, handler: { action in
                thirdActionCompletion?()
            }))
        }
        if hasCancel ?? false {
            alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        }
        
        from?.present(alert, animated: true, completion: nil)
    }
}



