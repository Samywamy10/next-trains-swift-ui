//
//  DepartureView.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 3/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import SwiftUI

struct DepartureView: View {
    var departure: Departure
    
    var body: some View {
        HStack {
            Text(departure.stationName).padding()
            Spacer()
            VStack{
                Text("Platform \(departure.platform)").font(.headline)
                Text("\(departure.minutesTilDeparture)m")
            }.padding()
        }.background(departure.gradient).foregroundColor(.white)
    }
}

struct DepartureView_Previews: PreviewProvider {
    static var previews: some View {
        DepartureView(departure: Departure(dateTime: Date(), platform: 2, stationName: "Flinders Street", gradient: LinearGradient(gradient: Gradient(colors: [Color(red: 0.46, green: 0.73, blue: 0.94), Color(red: 0.278, green: 0.517, blue: 0.908)]), startPoint: .top, endPoint: .bottom)))
    }
}
