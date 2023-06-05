//
//  MockAPIManager.swift
//  SportFlashTests
//
//  Created by ahmed osama on 05/06/2023.
//

import Foundation
@testable import SportFlash
class MockNetworkManager{
    var shouldReturnError: Bool
    init(shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
   
    let mockItemsJSONResponse :String =
"""
{
  "success": 1,
  "result": [
    {
         "league_key": "205",
         "league_name": "Coppa Italia",
         "country_key": "5",
         "country_name": "Italy",
         "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png",
         "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
     },
     {
         "league_key": "206",
         "league_name": "Serie B",
         "country_key": "5",
         "country_name": "Italy",
         "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/206_serie-b.png",
         "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
     }
    ]
}
"""
    enum ResponseWithError : Error {
        case responseError
    }
}

extension MockNetworkManager : SportsAPIProtocol{
    func fetchData<T>(for sport: Sport, queryItems: [URLQueryItem], completion: @escaping (Result<[T]?, Error>) -> Void) where T : Decodable {
        if shouldReturnError{
            completion(Result.failure(ResponseWithError.responseError ) )
        }else{
            do{
                let result = try JSONDecoder().decode(Response<T>.self, from:mockItemsJSONResponse.data(using: .utf8)!)
                
                completion(Result.success(result.result))
            }catch let error{
                completion(Result.failure(error))
            }
        }
    }
    

}
