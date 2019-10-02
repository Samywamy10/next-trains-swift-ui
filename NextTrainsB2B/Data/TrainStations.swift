//
//  TrainStation.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 1/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

final class TrainStations: ObservableObject, Identifiable {
    @Published var departures: [Departure] = []
    
    func fetch() {
        self.departures = []
        let db = Firestore.firestore()
        db.collection("nextDepartures").order(by: "current_time", descending: true).limit(to: 1)
            .getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                let document = documents[0].data()
                self.departures.append(contentsOf: self.createDepartures(inputDepartures: document["parliament"], stationName: "Parliament", gradient: LinearGradient(gradient: Gradient(colors: [Color(red: 0.46, green: 0.73, blue: 0.94), Color(red: 0.278, green: 0.517, blue: 0.908)]), startPoint: .top, endPoint: .bottom)))
                self.departures.append(contentsOf: self.createDepartures(inputDepartures: document["southern_cross"], stationName: "Southern Cross", gradient: LinearGradient(gradient: Gradient(colors: [Color(red: 0.086, green: 0.806, blue: 0.240), Color(red: 0.057, green: 0.6, blue: 0.170)]), startPoint: .top, endPoint: .bottom)))
                self.departures.append(contentsOf: self.createDepartures(inputDepartures: document["richmond"], stationName: "Richmond", gradient: LinearGradient(gradient: Gradient(colors: [Color(red: 1.00, green: 0.51, blue: 0.00), Color(red: 1.00, green: 0.30, blue: 0.00)]), startPoint: .top, endPoint: .bottom)))
        }
    }
    
    private func createDepartures(inputDepartures: Any?, stationName: String, gradient: LinearGradient) -> [Departure] {
        var departures: [Departure] = []
        for inputDeparture in inputDepartures as! [Any?] {
            let unwrappedInputDeparture = inputDeparture as! [String: Any]
            var dateString = unwrappedInputDeparture["dateTime"] as! String
            dateString = dateString + "+0000"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:dateString)!
            let departure = Departure(dateTime: date, platform: (unwrappedInputDeparture["platform_number"] as? Int)!, stationName: stationName, gradient: gradient)
            departures.append(departure)
        }
        return departures
    }
}
