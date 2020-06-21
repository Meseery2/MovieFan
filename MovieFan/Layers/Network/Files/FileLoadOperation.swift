//
//  FileLoadOperation.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class FileLoadOperation: Operation {

    public var downloadCompletionHandler: ((_ image: UIImage?, _ url: String, _ indexPath: IndexPath?, _ size: CGSize) -> Void)?
    
    private(set) var url: String
    private let size: CGSize
    private let indexPath: IndexPath?
    
    private let cacheDirectory: URL
    private let fileManager: FileManager
    
    init(url: String, size: CGSize, indexPath: IndexPath?, cacheDir: URL, fileManager: FileManager) {
        self.url = url
        self.size = size
        self.indexPath = indexPath
        self.cacheDirectory = cacheDir
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
        _cancelled = true
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
    
    override var isCancelled: Bool {
        return _cancelled
    }
    
    private var _cancelled = false {
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
    
    private func load() {
        let fileName = url.components(separatedBy: "/").last!
        let originalFile = cacheDirectory.appendingPathComponent("\(fileName)")
        let scaleFile = cacheDirectory.appendingPathComponent("\(fileName)\(size.width)x\(size.height)")
        
        if fileManager.fileExists(atPath: scaleFile.relativePath),
            let data = try? Data(contentsOf: scaleFile),
            let image = UIImage(data: data),
            let scaledImage = image.resizedImageWith(image: image, targetSize: size)  {
            
            completed(image: scaledImage)
            
        } else if fileManager.fileExists(atPath: originalFile.relativePath),
            let data = try? Data(contentsOf: originalFile),
            let image = UIImage(data: data),
            let scaleImage = image.resizedImageWith(image: image, targetSize: size)  {
            
            saveImageToDisk(originalImage: nil, scaledImage: scaleImage)
            completed(image: image)
            
        } else {
            completed(image: nil)
        }
    }
    
    private func saveImageToDisk(originalImage: UIImage?, scaledImage: UIImage?) {
        let fileName = url.components(separatedBy: "/").last!
        let originalFile = self.cacheDirectory.appendingPathComponent("\(fileName)")
        let scaleFile = self.cacheDirectory.appendingPathComponent("\(fileName)\(size.width)x\(size.height)")
        
        if let _origImage = originalImage, !self.fileManager.fileExists(atPath: originalFile.relativePath) {
            try? _origImage.jpegData(compressionQuality: 1)?.write(to: originalFile)
        }
        
        if let _scaleImage = scaledImage, !self.fileManager.fileExists(atPath: scaleFile.relativePath) {
            try? _scaleImage.jpegData(compressionQuality: 1)?.write(to: scaleFile)
        }
    }
    
    private func completed(image: UIImage?) {
        if !isCancelled {
            downloadCompletionHandler?(image, url, indexPath, size)
            finish(true)
            executing(false)
        }
    }
}
