//
//  League.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import Foundation

class LeagueResponse: Codable {
    let success: Int
    let result: [League]
    
    init(success: Int, result: [League]) {
        self.success = success
        self.result = result
    }
}
struct League: Codable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String
    let leagueLogo: String?
    let countryLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
    
    init(leagueKey: Int, leagueName: String, countryKey: Int, countryName: String, leagueLogo: String?, countryLogo: String?) {
        self.leagueKey = leagueKey
        self.leagueName = leagueName
        self.countryKey = countryKey
        self.countryName = countryName
        self.leagueLogo = leagueLogo
        self.countryLogo = countryLogo
    }
    
}
