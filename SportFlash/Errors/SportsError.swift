//
//  SportsError.swift
//  SportFlash
//
//  Created by ahmed osama on 01/06/2023.
//

import Foundation
enum SportsError: Error {
    case noDataAvailable
    case requestFailed
    case invalidResponse
    // Add more error cases as needed
    
    var localizedDescription: String {
        switch self {
        case .noDataAvailable:
            return "No data available"
        case .requestFailed:
            return "Request failed"
        case .invalidResponse:
            return "Invalid response"
        }
    }
}
