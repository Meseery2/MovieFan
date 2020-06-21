//
//  ImageDownloadManager.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class ImageDownloadManager {
    
    static let shared = ImageDownloadManager()
    
    typealias ImageDownloadHandler = (_ image: UIImage?, _ url: String, _ indexPath: IndexPath?, _ error: APIError?) -> Void

    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.moviedb.imagedownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    lazy var diskCacheQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.moviedb.diskcachequeue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let cacheDir: URL
    private let fileManager: FileManager
    
    private init() {
        imageCache.totalCostLimit = 250 * 1024 * 1024
        fileManager = FileManager.default
        cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("moviesdb")
        // var isDir: ObjCBool = false
        try? fileManager.createDirectory(at: cacheDir, withIntermediateDirectories: true, attributes: nil)
    }
    
    public func download(url: String, indexPath: IndexPath?, size: CGSize, completion: @escaping ImageDownloadHandler) {
        if url.isEmpty { return }
        
        let requiredUrl = "\(url)\(size.width)x\(size.height)"
        
        if let cachedImage = imageCache.object(forKey: requiredUrl as NSString) {
            completion(cachedImage, url, indexPath, nil)
        } else {
            
            if let ongoingOperation = imageDownloadQueue.operations as? [ImageDownloadOperation],
                let imgOperation = ongoingOperation.first(where: {
                    return ($0.imagePath == url) && $0.isExecuting && !$0.isFinished
                }) {
                imgOperation.queuePriority = .high
            } else {
                addToOperation(url: url, indexPath: indexPath, size: size, completion: completion)
            }
            
        }
    }
    
    private func addToFileLoadOperation(url: String, indexPath: IndexPath?, size: CGSize, completion: @escaping ImageDownloadHandler) {
        let operation = FileLoadOperation(url: url, size: size, indexPath: indexPath, cacheDir: cacheDir, fileManager: fileManager)
        operation.queuePriority = .veryHigh
        operation.downloadCompletionHandler = { [unowned self] (image, url, indexPath, size) in
            
            if let _image = image {
                let requiredUrl = "\(url)\(size.width)x\(size.height)"
                self.imageCache.setObject(_image, forKey: requiredUrl as NSString)
                completion(_image, url, indexPath, nil)
            } else {
                self.addToOperation(url: url, indexPath: indexPath, size: size, completion: completion)
            }
            
        }
        diskCacheQueue.addOperation(operation)
    }
    
    private func addToOperation(url: String, indexPath: IndexPath?, size: CGSize, completion: @escaping ImageDownloadHandler) {
        let imageOperation = ImageDownloadOperation(url: url, size: size, indexPath: indexPath, cacheDir: cacheDir, fileManager: fileManager)
        imageOperation.queuePriority = .veryHigh
        imageOperation.downloadCompletionHandler = { [unowned self] (image, url, indexPath, error) in
            if let _image = image,
                let scaledImage = _image.resizedImageWith(image: _image, targetSize: size) {
                let requiredUrl = "\(url)\(size.width)x\(size.height)"
                self.saveImageToDisk(originalImage: _image, scaledImage: scaledImage, url: url, size: size)
                self.imageCache.setObject(scaledImage, forKey: requiredUrl as NSString)
                completion(_image, url, indexPath, error)
            }
        }
        imageDownloadQueue.addOperation(imageOperation)
    }
    
    private func saveImageToDisk(originalImage: UIImage?, scaledImage: UIImage?, url: String, size: CGSize) {
        DispatchQueue.global(qos: .background).async {
            let fileName = url.components(separatedBy: "/").last!
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
    
    public func changeDownloadPriorityToSlow(of url: String) {
        guard let ongoingOpertions = imageDownloadQueue.operations as? [ImageDownloadOperation] else {
            return
        }
        let imageOperations = ongoingOpertions.filter {
            $0.imagePath == url && $0.isFinished == false && $0.isExecuting == true
        }
        guard let operation = imageOperations.first else {
            return
        }
        operation.queuePriority = .low
    }
    
    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
    
    func cancelOperation(imageUrl: String) {
        if let imageOperations = imageDownloadQueue.operations as? [ImageDownloadOperation],
            let operation = imageOperations.first(where: { $0.imagePath == imageUrl }) {
            operation.cancel()
        }
    }
}

