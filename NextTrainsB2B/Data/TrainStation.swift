//
//  TrainStation.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 1/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import Foundation

final class TrainStation: ObservableObject, Identifiable {
    @Published var name: String
    @Published var departures: [Departure]
    
    init(name: String, departures: [Departure]) {
        self.name = name
        self.departures = departures
    }
}
