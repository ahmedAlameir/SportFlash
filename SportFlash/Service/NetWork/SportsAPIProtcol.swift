//
//  SportsAPIProtcol.swift
//  SportFlash
//
//  Created by ahmed osama on 05/06/2023.
//

import Foundation
protocol SportsAPIProtocol{
    func fetchData<T: Decodable>(for sport: Sport, queryItems: [URLQueryItem], completion: @escaping (Result<[T]?, Error>) -> Void)
}
