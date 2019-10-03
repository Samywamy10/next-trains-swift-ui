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
            ForEach(departuresService.departures) { departure in
                DepartureView()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
