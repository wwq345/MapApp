//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by i564206 on 2022/3/14.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject{
    
    @Published var locations: [Location]
    
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    @Published var showLoactionList: Bool = false
    
    var mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init(){
//        self.location = []
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        mapRegion = MKCoordinateRegion(
            center: location.coordinates,
            span: mapSpan)
    }
    
    func toggleLocationList(){
        withAnimation(.easeInOut) {
            self.showLoactionList.toggle()
        }
    }
    
    func locatedPlace(loaction: Location){
        withAnimation (.easeInOut){
            mapLocation = loaction
            showLoactionList = false
        }
    }
    
    func nextLocation(){
//        var index = locations.firstIndex{ location in
//            return location == mapLocation
//        }
        
        guard let index = locations.firstIndex(where: { $0 == mapLocation })else{
            //error
            return
        }
        let nextIndex = index + 1
        guard locations.indices.contains(nextIndex) else{
            //error
            guard let firstLocation = locations.first else{ return }
            locatedPlace(loaction: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        locatedPlace(loaction: nextLocation)
        
    }
}
