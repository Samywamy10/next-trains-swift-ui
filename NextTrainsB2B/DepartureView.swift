//
//  DepartureView.swift
//  NextTrainsB2B
//
//  Created by Sam Wright on 3/10/19.
//  Copyright © 2019 Sam Wright. All rights reserved.
//

import SwiftUI

struct DepartureView: View {
    var body: some View {
        HStack {
            Text("Southern Cross").padding()
            Spacer()
            VStack{
                Text("Platform 10").font(.headline)
                Text("10m")
            }.padding()
        }.background(Color.red).foregroundColor(.white)
    }
}

struct DepartureView_Previews: PreviewProvider {
    static var previews: some View {
        DepartureView()
    }
}
