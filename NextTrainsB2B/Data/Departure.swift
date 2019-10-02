//
//  Departure.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 1/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import Foundation
import SwiftUI

final class Departure: ObservableObject, Identifiable {
    @Published var dateTime: Date
    @Published var platform: Int
    @Published var minutesTilDeparture: Int
    @Published var stationName: String
    @Published var gradient: LinearGradient
    
    init(dateTime: Date, platform: Int, stationName: String, gradient: LinearGradient) {
        self.dateTime = dateTime;
        self.platform = platform;
        self.minutesTilDeparture = Int(-Date().timeIntervalSince(dateTime) / 60)
        self.stationName = stationName
        self.gradient = gradient
    }
}
