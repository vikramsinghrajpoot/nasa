//
//  ImageView.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(urlStr: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: urlStr) else { return }
        contentMode = mode
        if let imageFromCache = AppImageCache.shared.imageCache.object(forKey: urlStr as NSString) as? UIImage{
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { () -> Void in
                AppImageCache.shared.imageCache.setObject(image, forKey: urlStr as NSString)
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        loadFrom(urlStr: link, contentMode: mode)
    }
    
}
