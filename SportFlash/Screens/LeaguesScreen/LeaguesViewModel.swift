//
//  LeaguesViewModel.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import Foundation
class LeaguesViewModel{
    private let sport: Sport
    private let sportsRepository: SportsRepository

    var leagues: [League] = [] {
        didSet {
            notifyDataUpdated()
        }
    }
    var onDataUpdated: (() -> Void)?
    init(sportsRepository: SportsRepository,sport: Sport) {
        self.sportsRepository = sportsRepository
        self.sport = sport
    }
    
    func fetchLeagues() {
        sportsRepository.fetchLeagues(for: sport) { result in
            switch result {
            case .success(let leagues):
                if let leagues = leagues{
                    self.leagues = leagues

                }else{
                    print("nill//////////////////////////////////////////")
                }
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
