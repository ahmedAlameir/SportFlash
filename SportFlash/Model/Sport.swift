//
//  Sport.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import Foundation
enum Sport {
    case football
    case basketball
    case cricket
    case tennis
    var path: String {
        switch self {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .cricket:
            return "cricket"
        case .tennis:
            return "tennis"
        }
        
    }
    var logo: String {
        switch self {
        case .football:
            return "footBall_logo"
        case .basketball:
            return "basketBall_logo"
        case .cricket:
            return "cricket_logo"
        case .tennis:
            return "tennis_logo"
        }
        
    }
}
