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
    var path: String {
        switch self {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        }
    }
}
