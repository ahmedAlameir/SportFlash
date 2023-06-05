//
//  File.swift
//  SportFlash
//
//  Created by ahmed osama on 29/05/2023.
//

import Foundation
protocol SportsRepository {
    func fetchLeagues(for sport: Sport, completion: @escaping (Result<[League]?, Error>) -> Void)
    func fetchFixtures(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Event]?, Error>) -> Void)
    func fetchLivescore(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Event]?, Error>) -> Void)
    func fetchTeams(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Team]?, Error>) -> Void)
    func fetchPlayers(for sport: Sport, leagueId: Int, completion: @escaping (Result<[Player]?, Error>) -> Void)

}
