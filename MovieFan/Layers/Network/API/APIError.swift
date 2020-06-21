//
//  APIError.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    
    case ParameterEncodingError
    case apiError(Error)
    case emptyData
    case invalidStatusCode(Int)
    case invalidRequestURL(URL)
    case responseSerializationFailed(Error)
    case somethingWentWrong
    
    public var description: String {
        switch self {
        case .ParameterEncodingError:
            return "Failed to encode data"
        case let .apiError(error):
            return "Network Error: \(error.localizedDescription)"
        case .emptyData:
            return "Empty response from the server"
        case let .invalidStatusCode(status):
            return "Server is down with status code: \(status)"
        case let .responseSerializationFailed(decodingError):
            return "Json Decoding Error: \(decodingError.localizedDescription)"
        case let .invalidRequestURL(url):
            return "Invalid URL. Please check the endPoint: \(url.absoluteString)"
        case .somethingWentWrong:
            return "Something went wrong."
        }
    }
    
}
