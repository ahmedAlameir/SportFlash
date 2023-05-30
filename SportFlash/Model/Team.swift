//
//  Team.swift
//  SportFlash
//
//  Created by ahmed osama on 23/05/2023.
//

import Foundation

struct Player: Codable {
    let playerKey: Int
    let playerName: String?
    let playerNumber: String?
    let playerCountry: String?
    let playerType: String?
    let playerAge: String?
    let playerMatchPlayed: String?
    let playerGoals: String?
    let playerYellowCards: String?
    let playerRedCards: String?
    let playerImage: String?
    enum CodingKeys: String, CodingKey {
            case playerKey = "player_key"
            case playerName = "player_name"
            case playerNumber = "player_number"
            case playerCountry = "player_country"
            case playerType = "player_type"
            case playerAge = "player_age"
            case playerMatchPlayed = "player_match_played"
            case playerGoals = "player_goals"
            case playerYellowCards = "player_yellow_cards"
            case playerRedCards = "player_red_cards"
            case playerImage = "player_image"
        }
}

struct Team: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?
    enum CodingKeys: String, CodingKey {
          case teamKey = "team_key"
          case teamName = "team_name"
          case teamLogo = "team_logo"
          case players
      }
}


