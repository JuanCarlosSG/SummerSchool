//
//  ContentView.swift
//  SummerSchool
//
//  Created by Juan Carlos Sánchez Gutiérrez on 17/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
                .environmentObject(SchoolViewModel())
        }
        .navigationViewStyle(.stack)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
