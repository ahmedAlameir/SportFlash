//
//  League.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import Foundation
import CoreData

class League:NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
    
   
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
             throw DecoderConfigurationError.missingManagedObjectContext
           }
        self.init(context: context)

           let container = try decoder.container(keyedBy: CodingKeys.self)
        leagueKey = try container.decode(Int32.self, forKey: .leagueKey)
        leagueName = try container.decode(String.self, forKey: .leagueName)
        countryKey = try container.decode(Int32.self, forKey: .countryKey)
        countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
        leagueLogo = try container.decodeIfPresent(String.self, forKey: .leagueLogo)
        countryLogo = try container.decodeIfPresent(String.self, forKey: .countryLogo)
    }
    
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

