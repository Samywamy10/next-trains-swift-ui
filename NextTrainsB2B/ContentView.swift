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
    @State var sortedByStations = true
    @State var sortedByPlatforms = false
    @State var sortedByTime = false
    
    var body: some View {
        VStack {
            HeaderView(sortedByStations: $sortedByStations, sortedByPlatforms: $sortedByPlatforms, sortedByTime: $sortedByTime)
            ScrollView {
                if(sortedByStations) {
                    ForEach(trainStations.departures.filter({ $0.stationName == "Southern Cross" }).prefix(3)) { departure in
                        DepartureView(departure: departure)
                    }
                    ForEach(trainStations.departures.filter({ $0.stationName == "Richmond" }).prefix(3)) { departure in
                        DepartureView(departure: departure)
                    }
                    ForEach(trainStations.departures.filter({ $0.stationName == "Parliament" }).prefix(3)) { departure in
                        DepartureView(departure: departure)
                    }
                } else if(sortedByPlatforms) {
                    ForEach(trainStations.departures.sorted(by: { $0.platform < $1.platform }).filter({$0.minutesTilDeparture <= 20})) { departure in
                        DepartureView(departure: departure)
                    }
                } else {
                    ForEach(trainStations.departures.sorted(by: { $0.minutesTilDeparture < $1.minutesTilDeparture }).filter({$0.minutesTilDeparture <= 20})) { departure in
                        DepartureView(departure: departure)
                    }
                }
            }
            Spacer()
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

struct HeaderView: View {
    @Binding var sortedByStations: Bool
    @Binding var sortedByPlatforms: Bool
    @Binding var sortedByTime: Bool
    
    func sortByStations() {
        sortedByStations = true
        sortedByPlatforms = false
        sortedByTime = false
    }
    
    func sortByPlatforms() {
        sortedByStations = false
        sortedByPlatforms = true
        sortedByTime = false
    }
    
    func sortByTime() {
        sortedByStations = false
        sortedByPlatforms = false
        sortedByTime = true
    }
    
    var body: some View {
        VStack {
            Text("NextTrains").font(.largeTitle)
            HStack {
                Button(action: sortByStations) {
                    Text("Stations")
                }.foregroundColor(.primary)
                Spacer()
                Button(action: sortByPlatforms) {
                    Text("Platforms")
                }.foregroundColor(.primary)
                Spacer()
                Button(action: sortByTime) {
                    Text("Time")
                }.foregroundColor(.primary)
            }.padding()
        }.padding()
    }
}

struct DepartureView: View {
    
    var departure: Departure
    
    var body: some View {
        HStack {
            
            Text(departure.stationName).padding()
            Spacer()
            VStack {
                Text("Platform \(departure.platform)").font(.headline)
                Text("\(departure.minutesTilDeparture)m")
            }.padding()
        }.background(departure.gradient)
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let trainStations = TrainStations()
        let departure1 = Departure(dateTime: Date(), platform: 6, stationName: "Flinders Street", gradient: LinearGradient(gradient: Gradient(colors: [Color(red: 1.00, green: 0.51, blue: 0.00), Color(red: 1.00, green: 0.30, blue: 0.00)]), startPoint: .top, endPoint: .bottom))
        let departure2 = Departure(dateTime: Date(), platform: 7, stationName: "Flinders Street", gradient: LinearGradient(gradient: Gradient(colors: [Color(red: 1.00, green: 0.51, blue: 0.00), Color(red: 1.00, green: 0.30, blue: 0.00)]), startPoint: .top, endPoint: .bottom))
        trainStations.departures = [departure1,departure2]
        return ContentView().environmentObject(trainStations)
    }
}
