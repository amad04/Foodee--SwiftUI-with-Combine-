//
//  YelpApiService.swift
//  Foodee
//
//  Created by Amad Walid on 2022-04-25.
//

import Foundation
import Combine
import CoreLocation


class YelpApiService {
  
    let apiKey = "Wkz9BieCUOllGUPyXoCf1fqDdHZhO5wSDKFKbUGLA0RceYcZSuZLplo_h7jP85ZiNzmqgQX5aYU15OwC9v_zwxWGRZRMK0ffKzfHXZkDCkXFlq33WSj0JbTQ8YNiYnYx"

    var cancellable = Set<AnyCancellable>()
    
    
    func request(term: String, location: CLLocation, categorie: String?) -> AnyPublisher<YelpModel, Error> {
        var urlComponent = URLComponents(string: "https://api.yelp.com")!
        urlComponent.path = "/v3/businesses/search"
        urlComponent.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "categories", value: categorie ?? "restaurants")
        ]
        
        let url = urlComponent.url!
        var request = URLRequest(url: url)

        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: YelpModel.self, decoder: JSONDecoder())
            .receive(on:  RunLoop.main)
            .eraseToAnyPublisher()
    }
}
