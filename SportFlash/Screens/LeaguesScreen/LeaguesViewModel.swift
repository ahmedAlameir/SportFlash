//
//  LeaguesViewModel.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import Foundation
class LeaguesViewModel {
    private let sportsRepository: SportsRepository
    private let sport: Sport
    
    private var leagues: [League] = [] {
        didSet {
            filteredLeagues = leagues
        }
    }
    private var filteredLeagues: [League] = [] {
        didSet {
            notifyDataUpdated()
        }
    }
    
    var onDataUpdated: (() -> Void)?
    var onFetchError: ((Error) -> Void)?
    
    init(sportsRepository: SportsRepository, sport: Sport) {
        self.sportsRepository = sportsRepository
        self.sport = sport
    }
    
    func fetchLeagues() {
        sportsRepository.fetchLeagues(for: sport) { [weak self] result in
            switch result {
            case .success(let leagues):
                if let leagues = leagues {
                    self?.leagues = leagues
                } else {
                    self?.onFetchError?(SportsError.noDataAvailable)
                }
            case .failure(let error):
                self?.onFetchError?(error)
            }
        }
    }
    
    func numberOfLeagues() -> Int {
        return filteredLeagues.count
    }
    
    func league(at index: Int) -> League? {
        guard index >= 0 && index < filteredLeagues.count else {
            return nil
        }
        return filteredLeagues[index]
    }
    private func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.onDataUpdated?()
        }
    }
    
    func filterLeagues(with filterText: String) {
        if filterText.isEmpty {
            filteredLeagues = leagues
        } else {
            filteredLeagues = leagues.filter { $0.leagueName.lowercased().contains(filterText.lowercased()) }
        }
    }
}
