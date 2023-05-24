//
//  SportsAPI.swift
//  SportFlash
//
//  Created by ahmed osama on 21/05/2023.
//

import Foundation

class SportsAPI {
    private let apiKey: String
    private let baseURL: URL
    
    init() {
        self.apiKey = "cdf813aa5d986f1758f3a4a36297867a848095b7ee2ac2c68073af05bb1c7a5c"
        self.baseURL = URL(string: "https://apiv2.allsportsapi.com/")!
    }
    
    
    func fetchLeagues(for sport: Sport, completion: @escaping (Result<[League], Error>) -> Void) {
        let endpoint = "Leagues"
        let queryItems = [
            URLQueryItem(name: "met", value: endpoint),
            URLQueryItem(name: "APIkey", value: apiKey)
        ]
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
                    let response = try decoder.decode(LeagueResponse.self, from: data)
                    completion(.success(response.result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchFixtures(for sport: Sport, from startDate: String, to endDate: String, leagueId: Int, completion: @escaping (Result<[Team], Error>) -> Void) {
        
        let endpoint = "Fixtures"
        let queryItems = [
            URLQueryItem(name: "met", value: endpoint),
            URLQueryItem(name: "APIkey", value: apiKey),
            URLQueryItem(name: "from", value: startDate),
            URLQueryItem(name: "to", value: endDate),
            URLQueryItem(name: "leagueId", value: String(leagueId))
        ]
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
                          let response = try decoder.decode(TeamResponse.self, from: data)
                          completion(.success(response.result))
                      } catch {
                          completion(.failure(error))
                      }
                  case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchTeams(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Team], Error>) -> Void) {
        
        let endpoint = "Teams"
        let queryItems = [
            URLQueryItem(name: "met", value: endpoint),
            URLQueryItem(name: "APIkey", value: apiKey),
            URLQueryItem(name: "leagueId", value: String(leagueId))
        ]
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
                          let response = try decoder.decode(TeamResponse.self, from: data)
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

