//
//  Response.swift
//  SportFlash
//
//  Created by ahmed osama on 28/05/2023.
//

import Foundation
struct Response<T: Decodable>:Decodable {
    let success: Int
    let result: [T]?
}
