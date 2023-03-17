//
//  ContentView.swift
//  RouletteApp
//
//  Created by User15 on 2023/3/1.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View
            {

                TabView {
                    Home(Home: .constant(true))
                        .tabItem {
                              Image(systemName: "house.circle.fill")
                              Text("Home")
                        }
                    Rou(ShowThirdView: .constant(true))
                        .tabItem {
                            Label("European Roulette ", systemImage: "figure.wave.circle")
                        }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
