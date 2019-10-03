//
//  ContentView.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 1/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import SwiftUI
import Firebase;



struct ContentView: View {
    @EnvironmentObject var departuresService: DeparturesService
    @State var sortedBy: String = "stations"
    
    var body: some View {
        Group {
            HeaderView(sortedBy: $sortedBy)
            ScrollView {
                if(sortedBy == "stations") {
                    ForEach(departuresService.departures.filter({ $0.stationName == "Southern Cross" }).prefix(3)) { departure in
                        DepartureView(departure: departure)
                    }
                    ForEach(departuresService.departures.filter({ $0.stationName == "Richmond" }).prefix(3)) { departure in
                        DepartureView(departure: departure)
                    }
                    ForEach(departuresService.departures.filter({ $0.stationName == "Parliament" }).prefix(3)) { departure in
                        DepartureView(departure: departure)
                    }
                } else if(sortedBy == "platforms") {
                    ForEach(departuresService.departures.sorted(by: { $0.platform < $1.platform }).filter({$0.minutesTilDeparture <= 20})) { departure in
                        DepartureView(departure: departure)
                    }
                } else {
                    ForEach(departuresService.departures.sorted(by: { $0.minutesTilDeparture < $1.minutesTilDeparture }).filter({$0.minutesTilDeparture <= 20})) { departure in
                        DepartureView(departure: departure)
                    }
                }
                
            }
        }.onAppear(perform: self.loadData)
    }
    
    private func loadData() {
        self.departuresService.fetch()
        let url = URL(string: "https://asia-northeast1-nextplatform.cloudfunctions.net/nextFlindersStPlatforms")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard data != nil else { return }
            self.departuresService.fetch()
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
