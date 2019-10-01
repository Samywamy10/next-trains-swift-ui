//
//  Departure.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 1/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import Foundation

final class Departure: ObservableObject, Identifiable {
    @Published var dateTime: Date
    @Published var platform: Int
    @Published var minutesTilDeparture: Int
    
    init(dateTime: Date, platform: Int) {
        self.dateTime = dateTime;
        self.platform = platform;
        self.minutesTilDeparture = Int(-Date().timeIntervalSince(dateTime) / 60)
    }
}
