//
//  ImageDownloader.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import UIKit

class ImageDownloader: UIImageView {
    var imageUrlString: String?
    static var imageCache = NSCache<NSString, UIImage>()

    func loadImage(urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let imageFromCache = ImageDownloader.imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                ImageDownloader.imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
        }).resume()
    }
}

