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
    private let sport: Sport

    var onUpcomingEventsUpdated: (() -> Void)?
    var onLatestEventsUpdated: (() -> Void)?
    var onTeamsUpdated: (() -> Void)?

    var onUpcomingError: ((SportsError) -> Void)?
    var onLatestError: ((SportsError) -> Void)?
    var onTeamsError: ((SportsError) -> Void)?

    
    private var upComingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []
    private var players: [Player] = []


    init(sportsRepository: SportsRepository, leagueId: Int, sport: Sport) {
        self.sportsRepository = sportsRepository
        self.leagueId = leagueId
        self.sport = sport
    }

    func fetchData() {
        fetchUpcomingEvents()
        fetchLatestEvents()
        if sport == Sport.tennis {
            fetchPlayer()
        }else{
            fetchTeams()
        }
    }

    private func fetchUpcomingEvents() {
        sportsRepository.fetchFixtures(for: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let events):
                self?.handleUpcomingEventsResult(events)
            case .failure(_):
                self?.onUpcomingError?(SportsError.invalidResponse)
            }
        }
    }

    private func handleUpcomingEventsResult(_ events: [Event]?) {
        if let upcomingEvents = events {
            upComingEvents = upcomingEvents
            onUpcomingEventsUpdated?()
        } else {
            onUpcomingError?(SportsError.noDataAvailable)
        }
    }

    private func fetchLatestEvents() {
        sportsRepository.fetchLivescore(for: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let events):
                self?.handleLatestEventsResult(events)
            case .failure(_):
                self?.onLatestError?(SportsError.invalidResponse)
            }
        }
    }

    private func handleLatestEventsResult(_ events: [Event]?) {
        if let latestEvents = events {
            self.latestEvents = latestEvents
            onLatestEventsUpdated?()
        } else {
            onLatestError?(SportsError.noDataAvailable)
        }
    }

    private func fetchTeams() {
        sportsRepository.fetchTeams(for: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let teams):
                self?.handleTeamsResult(teams)
            case .failure(_):
                self?.onTeamsError?(SportsError.invalidResponse)
            }
        }
    }

    private func handleTeamsResult(_ teams: [Team]?) {
        if let teams = teams {
            self.teams = teams
            onTeamsUpdated?()
        } else {
            onTeamsError?(SportsError.noDataAvailable)
        }
    }
    private func fetchPlayer() {
        sportsRepository.fetchPlayers(for: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.handlePlayerResult(player)
            case .failure(_):
                self?.onTeamsError?(SportsError.invalidResponse)
            }
        }
    }

    private func handlePlayerResult(_ player: [Player]?) {
        if let player = player {
            self.players = player
            onTeamsUpdated?()
        } else {
            onTeamsError?(SportsError.noDataAvailable)
        }
    }
    // Provide necessary methods to access data in the view controller
    func upComingEventsCount() -> Int {
        return upComingEvents.count
    }

    func latestEventsCount() -> Int {
        return latestEvents.count
    }

    func teamsCount() -> Int {
        return teams.count
    }
    func playersCount() -> Int {
        return players.count
    }
    func upComingEvent(at index: Int) -> Event {
        return upComingEvents[index]
    }

    func latestEvent(at index: Int) -> Event {
        return latestEvents[index]
    }

    func team(at index: Int) -> Team {
        return teams[index]
    }
    func players(at index: Int) -> Player {
        return players[index]
    }
    func teamLogo(at index: Int) -> String? {
        return teams[index].teamLogo
    }

 
}

