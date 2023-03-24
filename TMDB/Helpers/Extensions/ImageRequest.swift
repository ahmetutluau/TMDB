//
//  ImageRequest.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 3.03.2023.
//

import Kingfisher
import UIKit

class ImageRequest {
    static func setImg(image: UIImageView?, imgLink: String) -> (){
        let urlString = imgLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url =  URL(string: urlString)
        
        
        image!.kf.indicatorType = .activity
        image!.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    static func setImgWithCompletion(image: UIImageView?, imgLink: String, success: @escaping (_ isEmpty: Bool? )->()) -> (){
    //    let url = URL(string: imgLink)
        let url : String = imgLink
        let urlStr : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let convertedURL : URL = URL(string: urlStr)!
        print(convertedURL)
        
        image!.kf.indicatorType = .activity
        image!.kf.setImage(
            with: convertedURL,
            placeholder: UIImage(named: "bt-logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}




extension String {
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
