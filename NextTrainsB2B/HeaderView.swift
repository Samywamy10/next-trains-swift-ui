//
//  HeaderView.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 3/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            Text("NextTrains").font(.largeTitle)
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Stations")
                }.foregroundColor(.primary)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Platforms")
                }.foregroundColor(.primary)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Time")
                }.foregroundColor(.primary)
            }
        }.padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}