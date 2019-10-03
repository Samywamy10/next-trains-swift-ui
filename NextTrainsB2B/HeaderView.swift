//
//  HeaderView.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 3/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @Binding var sortedBy: String
    
    var body: some View {
        VStack {
            Text("NextTrains").font(.largeTitle)
            HStack {
                Button(action: {self.sortedBy = "stations"}) {
                    Text("Stations")
                }.foregroundColor(.primary)
                Spacer()
                Button(action: {self.sortedBy = "platforms"}) {
                    Text("Platforms")
                }.foregroundColor(.primary)
                Spacer()
                Button(action: {self.sortedBy = "time"}) {
                    Text("Time")
                }.foregroundColor(.primary)
            }
        }.padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(sortedBy: .constant("stations"))
    }
}
