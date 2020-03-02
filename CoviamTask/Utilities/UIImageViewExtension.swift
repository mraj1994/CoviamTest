//
//  UIImageViewExtension.swift
//  CoviamTask
//
//  Created by QuietGrowth pty ltd on 02/03/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>() //imageCaching declaration

extension UIImageView {
    
        func loadImageUsingCache(withUrl urlString : String) {
            let url = URL(string: urlString)
            if url == nil {return}
            self.image = nil

            // check cached image
            if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
                self.image = cachedImage
                return
            }

            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
            addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            activityIndicator.center = self.center

            // if not, download image from url
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                        activityIndicator.removeFromSuperview()
                    }
                }

            }).resume()
        }
}
