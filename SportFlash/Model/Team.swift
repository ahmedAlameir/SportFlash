//
//  Team.swift
//  SportFlash
//
//  Created by ahmed osama on 23/05/2023.
//

import Foundation


struct Team: Codable {
    let teamKey: Int
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


