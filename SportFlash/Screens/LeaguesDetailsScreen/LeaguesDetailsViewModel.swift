//
//  LeaguesDetailsViewModel.swift
//  SportFlash
//
//  Created by ahmed osama on 25/05/2023.
//

import Foundation
class LeaguesDetailsViewModel {
    private let sportsRepository: SportsRepository
    private let leagueId: Int
    private let sport:Sport
    // Data properties with didSet observers
    var upComingEvents: [Event] = [] {
        didSet {
            upComingEventsUpdated?()
        }
    }
    
    var latestEvents: [Event] = [] {
        didSet {
            latestEventsUpdated?()
        }
    }
    var teams: [Team] = [] {
        didSet {
            teamsUpdated?()
        }
    }
    
    // Callbacks for data updates
    var upComingEventsUpdated: (() -> Void)?
    var latestEventsUpdated: (() -> Void)?
    var teamsUpdated: (() -> Void)?
    
    init(sportsRepository: SportsRepository,leagueId:Int,sport:Sport) {
        self.sportsRepository = sportsRepository
        self.leagueId = leagueId
        self.sport = sport
        fetchUpComingEvents()
        fetchLatestEvents()
        fetchTeams()
    }
    
    func fetchUpComingEvents() {
        // Perform API request to fetch upcoming events
        sportsRepository.fetchFixtures(for: sport, leagueId: leagueId){ [weak self] result in
            switch result {
            case .success(let events):
                if let events = events{
                    self?.upComingEvents = events

                }else{
                    print("nill//////////////////////////////////////////")
                }
            case .failure(let error):
                // Handle error
                print("Error fetching upcoming events: \(error)")
            }
        }
    }
    
    func fetchLatestEvents() {
        // Perform API request to fetch latest events
        sportsRepository.fetchLivescore(for: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let events):
                if let events = events{
                    self?.latestEvents = events

                }else{
                    print("nill//////////////////////////////////////////")
                }
            case .failure(let error):
                // Handle error
                print("Error fetching latest events: \(error)")
            }
        }
    }
    
    func fetchTeams() {
        // Perform API request to fetch teams
        sportsRepository.fetchTeams(for: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let teams):
                if let teams = teams{
                    self?.teams = teams

                }else{
                    print("nill//////////////////////////////////////////")
                }
            case .failure(let error):
                // Handle error
                print("Error fetching teams: \(error)")
            }
        }
    }
}
