//
//  HomeViewModel.swift
//  Foodee
//
//  Created by Amad Walid on 2022-04-25.
//


import SwiftUI
import Combine
import CoreLocation

class HomeViewModel: ObservableObject {

    var yelpApisService = YelpApiService()

    var cancellable = Set<AnyCancellable>()
    @Published var businesses: [Business] = []


    init() {
    }

    func search() {
        yelpApisService.request(term: "", location: .init(latitude: 59.3293235, longitude: 18.0685808), categorie: "")
            .sink(receiveCompletion: { complition in
                switch complition {
                case .finished:
                    print("Finished")
                
                case . failure(let error):
                    print(error.localizedDescription)
                    
                }
            }, receiveValue: { model in
                self.businesses = model.businesses
            })
            .store(in: &cancellable)
    }
}
