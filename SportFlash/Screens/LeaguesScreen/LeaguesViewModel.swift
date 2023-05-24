//
//  LeaguesViewModel.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import Foundation
class LeaguesViewModel{
    private let sportsAPI: SportsAPI
    private let sport: Sport
    
    var leagues: [League] = [] {
        didSet {
            notifyDataUpdated()
        }
    }
    var onDataUpdated: (() -> Void)?
    init(sportsAPI: SportsAPI,sport: Sport) {
        self.sportsAPI = sportsAPI
        self.sport = sport
    }
    
    func fetchLeagues() {
        sportsAPI.fetchLeagues(for: sport) { result in
            switch result {
            case .success(let leagues):
                self.leagues = leagues
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    private func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.onDataUpdated?()
        }
    }
    
}
