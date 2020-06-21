//
//  APIServiceMock.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class APIHTTPClientMock: APIHTTPClientType {
    func dataTask(urlRequest: URLRequest, completion: @escaping ((Result<Data, APIError>) -> Void)) {
        switch urlRequest.url?.path {
        case MovieRoute.nowPlayingMovies.url.path:
            if urlRequest.url?.query?.contains("page=1") ?? false {
                let bundle = Bundle(for: type(of: self))
                let fileUrl = bundle.url(forResource: "Movies", withExtension: "json")!
                let data = try! Data(contentsOf: fileUrl)
                completion(Result.success(data))
            } else if urlRequest.url?.query?.contains("page=2") ?? false {
                let bundle = Bundle(for: type(of: self))
                let fileUrl = bundle.url(forResource: "EmptyMoviesResponse", withExtension: "json")!
                let data = try! Data(contentsOf: fileUrl)
                completion(Result.success(data))
            }else {
                let data = "".data(using: .utf8)
                completion(Result.success(data!))
            }
            break
            
        default:
            completion(Result.failure(APIError.invalidRequestURL(urlRequest.url!)))
            break
        }
    }
    
    func downloadTask(url: String, completion: @escaping ((Result<URL, APIError>) -> Void)) {}
    
    func cancel() {}
}
