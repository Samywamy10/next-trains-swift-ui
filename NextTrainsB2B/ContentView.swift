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
    
    @EnvironmentObject var trainStations: TrainStations
    
    var body: some View {
        ScrollView {
            ForEach(trainStations.stations) { trainStation in
                VStack {
                    TrainStationView(trainStation: trainStation)
                    
                }
                
            }
        }.onAppear(perform: self.loadData)
        //}
    }
    
    private func loadData() {
        self.trainStations.fetch()
        let url = URL(string: "https://asia-northeast1-nextplatform.cloudfunctions.net/nextFlindersStPlatforms")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard data != nil else { return }
            self.trainStations.fetch()
        }
        task.resume()
        
    }
}

struct TrainStationView: View {
    
    var trainStation: TrainStation
    
    var body: some View {
        Group {
            if(trainStation.departures.count > 0) {
                Text(trainStation.name).font(.title).foregroundColor(.blue)
                VStack {
                    HStack {
                        Text("Platform \(trainStation.departures[0].platform)").padding(20)
                        Text("\(trainStation.departures[0].minutesTilDeparture) minutes").padding(20)
                    }.background(LinearGradient(gradient: Gradient(colors: [Color(red: 1.00, green: 0.51, blue: 0.00), Color(red: 1.00, green: 0.30, blue: 0.00)]), startPoint: .top, endPoint: .bottom))
                        .foregroundColor(.white).padding(10)
                    ForEach(trainStation.departures.suffix(from: 1)) { departure in
                        HStack {
                            Text("Platform \(departure.platform) in \(departure.minutesTilDeparture) minutes")
                            Spacer()
                        }.padding(10)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let trainStations = TrainStations()
        let departure1 = Departure(dateTime: Date(), platform: 6)
        let departure2 = Departure(dateTime: Date(), platform: 7)
        let parliament = TrainStation(name: "Parliament", departures: [departure1, departure2])
        trainStations.stations = [parliament]
        return ContentView().environmentObject(trainStations)
    }
}
