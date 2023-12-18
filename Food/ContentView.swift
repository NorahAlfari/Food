//
//  ContentView.swift
//  Food
//
//  Created by Norah Alfari on 01/06/1445 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                       // Tab 1
                RestaurantView()
                           .tabItem {
                               Image(systemName: "homekit")
                               Text("Home")
                           }
                           .tag(0)
                       
                       // Tab 2
                OrderView()
                           .tabItem {
                               Image(systemName: "list.bullet.rectangle.portrait")
                               Text("Order")
                           }
                           .tag(1)
                       
            }.tint(Color.orange)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
