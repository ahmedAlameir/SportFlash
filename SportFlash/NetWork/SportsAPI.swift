//
//  SportsAPI.swift
//  SportFlash
//
//  Created by ahmed osama on 21/05/2023.
//

import Foundation
import CoreData
class SportsAPI {
    private let baseURL: URL
    
    init() {
        self.baseURL = URL(string: "https://apiv2.allsportsapi.com/")!
    }
 
    func fetchData<T: Decodable>(for sport: Sport, queryItems: [URLQueryItem], completion: @escaping (Result<[T]?, Error>) -> Void) {
        let sportPath = sport.path
        var components = URLComponents(url: baseURL.appendingPathComponent(sportPath), resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        performRequest(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()

                    let response = try decoder.decode(Response<T>.self, from: data)
                    completion(.success(response.result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func performRequest(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

