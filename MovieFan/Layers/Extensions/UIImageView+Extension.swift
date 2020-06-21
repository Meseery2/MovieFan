//
//  UIImageView+Extension.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit


extension UIImageView {
    struct ImageView {
        static var imageURLKey: Void?
    }
    
    private var imageURL: String? {
        get {
            return objc_getAssociatedObject(self, &ImageView.imageURLKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &ImageView.imageURLKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func load(url: String, indexPath: IndexPath) {
        if let previousURL = imageURL {
            ImageDownloadManager.shared.changeDownloadPriorityToSlow(of: previousURL)
        }
        imageURL = url
        ImageDownloadManager.shared.download(url: url, indexPath: indexPath, size: self.frame.size) { [weak self](image, url, indexPathh, error) in
            DispatchQueue.main.async {
                if let strongSelf = self, let _image = image, let _path = strongSelf.imageURL, _path == url {
                    strongSelf.imageURL = nil
                    strongSelf.image = _image
                }
            }
        }
    }
    
    func load(url: String) {
        ImageDownloadManager.shared.download(url: url, indexPath: nil, size: self.frame.size) { (image, url, indexPathh, error) in
            if let _image = image {
                DispatchQueue.main.async {
                    self.image = _image
                }
            }
        }
    }
    
    func resizedImageWith(image: UIImage, targetSize: CGSize) -> UIImage? {
        return image.resizedImageWith(image: image, targetSize: targetSize)
    }
}
