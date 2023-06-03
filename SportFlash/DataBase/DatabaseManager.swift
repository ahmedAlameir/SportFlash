//
//  DatabaseManager.swift
//  SportFlash
//
//  Created by ahmed osama on 30/05/2023.
//

import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private  var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportFlash") // Replace with your Core Data model name
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    private var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Save League
    
    func saveTeam(team: Team) {
        let teamEntity = NSEntityDescription.insertNewObject(forEntityName: "TeamEntity", into: managedContext) as! TeamEntity
        
        teamEntity.teamKey = Int32(team.teamKey )
        teamEntity.teamName = team.teamName
        teamEntity.teamLogo = team.teamLogo
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save team: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Retrieve Teams
    
    func retrieveTeams() -> [Team] {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        
        do {
            let teamEntities = try managedContext.fetch(fetchRequest)
            
            return teamEntities.map { teamEntity in
                return Team(teamKey: Int(teamEntity.teamKey),
                            teamName: teamEntity.teamName,
                            teamLogo: teamEntity.teamLogo,
                            players: nil)
            }
        } catch let error as NSError {
            print("Failed to retrieve teams: \(error), \(error.userInfo)")
            return []
        }
    }
    func teamExists(teamId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "teamKey == %d", teamId)
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try managedContext.count(for: fetchRequest)
            return count > 0
        } catch let error as NSError {
            print("Failed to check team existence: \(error), \(error.userInfo)")
            return false
        }
    }
    func deleteTeam(teamId: Int) {
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "teamKey == %d", teamId)
        fetchRequest.fetchLimit = 1
        
        do {
            let teams = try managedContext.fetch(fetchRequest)
            if let team = teams.first {
                managedContext.delete(team)
                try managedContext.save()
                print("Team deleted successfully.")
            } else {
                print("Team not found.")
            }
        } catch let error as NSError {
            print("Failed to delete team: \(error), \(error.userInfo)")
        }
    }
    
    
    func saveLeagues(leagues: [League],sport :Sport) {
        leagues.forEach { league in
            let leagueEntity = NSEntityDescription.insertNewObject(forEntityName: "LeagueEntity", into: managedContext) as! LeagueEntity
            
            leagueEntity.leagueKey =  Int32(league.leagueKey)
            leagueEntity.sport = Int32(sport.id)
            leagueEntity.leagueName = league.leagueName
            leagueEntity.countryKey =  Int32(league.countryKey ?? -1)
            leagueEntity.countryName = league.countryName
            leagueEntity.leagueLogo = league.leagueLogo
            leagueEntity.countryLogo = league.countryLogo
        }

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Failed to save leagues: \(error), \(error.userInfo)")
            }
    }
    
    // MARK: - Retrieve Leagues
    
    func retrieveLeagues(withSport sport: Sport) -> [League]? {
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sport == %d", sport.id)
        
        do {
            let leagueEntities = try managedContext.fetch(fetchRequest)
            
            return leagueEntities.map { leagueEntity in
                return League(leagueKey: Int(leagueEntity.leagueKey),
                              leagueName: leagueEntity.leagueName ?? "",
                              countryKey: Int(leagueEntity.countryKey ),
                              countryName: leagueEntity.countryName ?? "",
                              leagueLogo: leagueEntity.leagueLogo,
                              countryLogo: leagueEntity.countryLogo)
            }
        } catch let error as NSError {
            print("Failed to retrieve leagues: \(error), \(error.userInfo)")
            return nil
        }
    }
}
