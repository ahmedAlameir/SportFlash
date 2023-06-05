//
//  FavouriteViewModel.swift
//  SportFlash
//
//  Created by ahmed osama on 01/06/2023.
//

import Foundation

class FavoriteViewModel {
    private let databaseManager: DatabaseManager
    private var teams: [Team] = [] {
        didSet {
            teamsDidChange?()
        }
    }
    
    var teamsDidChange: (() -> Void)?
    
    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
    func retrieveTeams() {
        teams = databaseManager.retrieveTeams()
    }
    
    func deleteTeam(at index: Int) {
        let team = teams[index]
        databaseManager.deleteTeam(teamId: team.teamKey)
        teams.remove(at: index)
    }
    
    func team(at index: Int) -> Team {
        return teams[index]
    }
    
    func numberOfTeams() -> Int {
        return teams.count
    }
}
