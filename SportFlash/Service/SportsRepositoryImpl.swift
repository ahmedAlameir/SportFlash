//
//  SportsRepositoryImpl.swift
//  SportFlash
//
//  Created by ahmed osama on 29/05/2023.
//

import Foundation
import Network
class SportsRepositoryImpl:SportsRepository{

    let api:SportsAPI
    let sportdb:DatabaseManager

    
    init(api :SportsAPI,sportdb :DatabaseManager){
        self.api = api
        self.sportdb = sportdb

        
    }
    func fetchLeagues(for sport: Sport, completion: @escaping (Result<[League]?, Error>) -> Void) {
        
        let queryItems = [
            URLQueryItem(name: "met", value: "Leagues"),
            URLQueryItem(name: "APIkey", value: API_KYE)
        ]
        self.api.fetchData(for: sport, queryItems: queryItems) { (result: Result<[League]?, Error>) in
            switch result {
            case .success(let leagues):
                completion(.success(leagues))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
        
    }
    
    func fetchFixtures(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Event]?, Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let endDate = Calendar.current.date(byAdding: .day, value: 360, to:  Date())!
        let startDateString = dateFormatter.string(from:  Date())
        let endDateString = dateFormatter.string(from: endDate)
        
        let endpoint = "Fixtures"
        let queryItems = [
            URLQueryItem(name: "met", value: endpoint),
            URLQueryItem(name: "APIkey", value: API_KYE),
            URLQueryItem(name: "from", value: startDateString),
            URLQueryItem(name: "to", value: endDateString),
            URLQueryItem(name: "leagueId", value: String(leagueId))
        ]
        api.fetchData(for: sport, queryItems: queryItems) { (result: Result<[Event]?, Error>) in
            switch result {
            case .success(let event):
                
                    completion(.success(event))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLivescore(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Event]?, Error>) -> Void) {
        let endpoint = "Livescore"
        let queryItems = [
            URLQueryItem(name: "met", value: endpoint),
            URLQueryItem(name: "APIkey", value: API_KYE),
            
            URLQueryItem(name: "leagueId", value: String(leagueId))
        ]
        api.fetchData(for: sport, queryItems: queryItems) { (result: Result<[Event]?, Error>) in
            switch result {
            case .success(let event):
                    completion(.success(event))
               
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTeams(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Team]?, Error>) -> Void) {
        let endpoint = "Teams"
        let queryItems = [
            URLQueryItem(name: "met", value: endpoint),
            URLQueryItem(name: "APIkey", value: API_KYE),
            URLQueryItem(name: "leagueId", value: String(leagueId))
        ]
        api.fetchData(for: sport, queryItems: queryItems) { (result: Result<[Team]?, Error>) in
            switch result {
            case .success(let team):
                    completion(.success(team))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchPlayers(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Player]?, Error>) -> Void) {
        let endpoint = "Players"
        let queryItems = [
            URLQueryItem(name: "met", value: endpoint),
            URLQueryItem(name: "APIkey", value: API_KYE),
            URLQueryItem(name: "leagueId", value: String(leagueId))
        ]
        api.fetchData(for: sport, queryItems: queryItems) { (result: Result<[Player]?, Error>) in
            switch result {
            case .success(let player):
                    completion(.success(player))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
}
