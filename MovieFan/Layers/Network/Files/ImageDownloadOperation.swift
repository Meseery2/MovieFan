//
//  ImageDownloadOperation.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class ImageDownloadOperation: Operation {
    
    private var request: APIImageRequest?
    private var downloadTask: URLSessionTask?
    
    public var downloadCompletionHandler: ImageDownloadManager.ImageDownloadHandler?

    private(set) var imagePath: String
    private let size: CGSize
    private let indexPath: IndexPath?
    
    private let cacheDir: URL
    private let fileManager: FileManager
    
    init(url: String, size: CGSize, indexPath: IndexPath?, cacheDir: URL, fileManager: FileManager) {
        self.imagePath = url
        self.size = size
        self.indexPath = indexPath
        self.cacheDir = cacheDir
        self.fileManager = fileManager
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        executing(true)
        load()
    }
    
    override func cancel() {
        request?.cancel()
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _executing: Bool = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private func executing(_ executing: Bool) {
        _executing = executing
    }
    
    private func finish(_ finished: Bool) {
        _finished = finished
    }
    
    private func download() {
        request = APIImageRequest()
        request?.download(url: imagePath) { [weak self] (location, image, error) in
            self?.completed(image: image, error: error)
            self?.finish(true)
            self?.executing(false)
        }
    }
    
    private func completed(image: UIImage?, error: Error?) {
        self.downloadCompletionHandler?(image, imagePath, indexPath, error as? APIError)
    }
    
    private func fileLoadcompleted(image: UIImage?) {
        if !isCancelled {
            downloadCompletionHandler?(image, imagePath, indexPath, nil)
            finish(true)
            executing(false)
        }
    }
    
    private func load() {
        let fileName = imagePath.components(separatedBy: "/").last!
        let originalFile = cacheDir.appendingPathComponent("\(fileName)")
        let scaleFile = cacheDir.appendingPathComponent("\(fileName)\(size.width)x\(size.height)")
        
        if fileManager.fileExists(atPath: scaleFile.relativePath),
            let data = try? Data(contentsOf: scaleFile),
            let image = UIImage(data: data),
            let scaledImage = image.resizedImageWith(image: image, targetSize: size)  {
            
            fileLoadcompleted(image: scaledImage)
            
        } else if fileManager.fileExists(atPath: originalFile.relativePath),
            let data = try? Data(contentsOf: originalFile),
            let image = UIImage(data: data),
            let scaleImage = image.resizedImageWith(image: image, targetSize: size)  {
            
            saveImageToDisk(originalImage: nil, scaledImage: scaleImage)
            fileLoadcompleted(image: image)
            
        } else {
            download()
        }
    }

    private func saveImageToDisk(originalImage: UIImage?, scaledImage: UIImage?) {
        let fileName = imagePath.components(separatedBy: "/").last!
        let originalFile = self.cacheDir.appendingPathComponent("\(fileName)")
        let scaleFile = self.cacheDir.appendingPathComponent("\(fileName)\(size.width)x\(size.height)")
        
        if let _origImage = originalImage, !self.fileManager.fileExists(atPath: originalFile.relativePath) {
            try? _origImage.jpegData(compressionQuality: 1)?.write(to: originalFile)
        }
        
        if let _scaleImage = scaledImage, !self.fileManager.fileExists(atPath: scaleFile.relativePath) {
            try? _scaleImage.jpegData(compressionQuality: 1)?.write(to: scaleFile)
        }
    }
}
