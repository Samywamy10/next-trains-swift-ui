//
//  TrainStation.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 1/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import Foundation
import SwiftUI

final class TrainStation: ObservableObject, Identifiable {
    @Published var name: String
    @Published var departures: [Departure]
    @Published var gradient: LinearGradient
    
    init(name: String, departures: [Departure], gradient: LinearGradient) {
        self.name = name
        self.departures = departures
        self.gradient = gradient
    }
}
