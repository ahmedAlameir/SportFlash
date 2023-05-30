//
//  Event.swift
//  SportFlash
//
//  Created by ahmed osama on 25/05/2023.
//

import Foundation


struct Event: Codable {
    let eventDate: String?
    let eventHomeTeam: String?
    let eventFirstPlayer: String?
    let eventAwayTeam: String?
    let eventSecondPlayer: String?
    let eventFinalResult: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    enum CodingKeys: String, CodingKey {
           case eventDate = "event_date"
           case eventHomeTeam = "event_home_team"
           case eventFirstPlayer = "event_first_player"
           case eventAwayTeam = "event_away_team"
           case eventSecondPlayer = "event_second_player"
           case eventFinalResult = "event_final_result"
           case homeTeamLogo = "home_team_logo"
           case awayTeamLogo = "away_team_logo"
           case eventFirstPlayerLogo = "event_first_player_logo"
           case eventSecondPlayerLogo = "event_second_player_logo"
       }
}
