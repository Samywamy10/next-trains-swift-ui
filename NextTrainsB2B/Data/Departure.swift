//
//  Departure.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 3/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import Foundation
import SwiftUI

final class Departure: Identifiable {
    var dateTime: Date
    var platform: Int
    var minutesTilDeparture: Int
    var stationName: String
    var gradient: LinearGradient
    
    init(dateTime: Date, platform: Int, stationName: String, gradient: LinearGradient) {
        self.dateTime = dateTime;
        self.platform = platform;
        self.minutesTilDeparture = Int(-Date().timeIntervalSince(dateTime) / 60)
        self.stationName = stationName
        self.gradient = gradient
    }
}
