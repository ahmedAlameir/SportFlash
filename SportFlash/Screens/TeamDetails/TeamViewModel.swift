//
//  TeamViewModel.swift
//  SportFlash
//
//  Created by ahmed osama on 31/05/2023.
//

import Foundation
class TeamViewModel {
    let databaseManager:DatabaseManager
    init(databaseManager:DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
    func insertTeam(team: Team) {
        databaseManager.saveTeam(team: team)
    }
    func deleteTeam(teamId: Int) {
        // Delete the team using the TeamDatabaseManager
        // Modify the delete method in the TeamDatabaseManager according to your implementation
        databaseManager.deleteTeam(teamId: teamId)
        
    }
    func teamExists(teamId: Int) -> Bool {
        return databaseManager.teamExists(teamId: teamId)
    }
}
