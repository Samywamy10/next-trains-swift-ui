//
//  TrainStation.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 1/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import Foundation
import Firebase

final class TrainStations: ObservableObject, Identifiable {
    @Published var stations: [TrainStation] = []
    
    func fetch() {
        self.stations = []
        let db = Firestore.firestore()
        db.collection("nextDepartures").order(by: "current_time", descending: true).limit(to: 1)
            .getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                let document = documents[0].data()
                self.stations.append(TrainStation(name: "Parliament", departures: self.createDepartures(inputDepartures: document["parliament"])))
                self.stations.append(TrainStation(name: "Southern Cross", departures: self.createDepartures(inputDepartures: document["southern_cross"])))
                self.stations.append(TrainStation(name: "Richmond", departures: self.createDepartures(inputDepartures: document["richmond"])))
        }
    }
    
    private func createDepartures(inputDepartures: Any?) -> [Departure] {
        var departures: [Departure] = []
        for inputDeparture in inputDepartures as! [Any?] {
            let unwrappedInputDeparture = inputDeparture as! [String: Any]
            var dateString = unwrappedInputDeparture["dateTime"] as! String
            dateString = dateString + "+0000"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            let date = dateFormatter.date(from:dateString)!
            let departure = Departure(dateTime: date, platform: (unwrappedInputDeparture["platform_number"] as? Int)!)
            departures.append(departure)
        }
        return departures
    }
}
