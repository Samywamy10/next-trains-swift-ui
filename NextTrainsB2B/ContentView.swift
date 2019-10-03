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
    
    var body: some View {
        Group {
            HeaderView()
            ScrollView {
                ForEach(departuresService.departures) { departure in
                    DepartureView()
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
