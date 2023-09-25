//
//  RickandMortyErrors.swift
//  ZARAfit
//
//  Created by Davit on 25/09/23.
//

import Foundation
enum NetworkError: Error {
    case invalidInput
    case invalidURL
    case noData
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidInput:
            return "Invalid input"
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
}

