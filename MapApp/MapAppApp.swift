//
//  MapAppApp.swift
//  MapApp
//
//  Created by i564206 on 2022/3/14.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var lvm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(lvm)
        }
    }
}
