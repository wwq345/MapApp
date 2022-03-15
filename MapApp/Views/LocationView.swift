//
//  LocationView.swift
//  MapApp
//
//  Created by i564206 on 2022/3/14.
//

import SwiftUI
import MapKit
struct LocationView: View {
    
    @EnvironmentObject private var lvm: LocationsViewModel
    
    var body: some View {
        ZStack{
            //RandomAccessCollection: Idenfiable,Hashable
            mapPlayer
                .ignoresSafeArea(.all)
            
            VStack {
               
                header
                    .padding()
//                    .frame(maxWidth: 700) maxWidthForIpad
                
                
                Spacer()
                
                LocationPreviewZstack
    
            }
            
            
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationView{
    private var header: some View{
        VStack{
            Button(action: {
                self.lvm.toggleLocationList()
            }) {
                Text(lvm.mapLocation.name+","+lvm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: self.lvm.showLoactionList ? "arrow.up" : "arrow.down")
                            .imageScale(.large)
                            .font(.headline)
                            .padding(.leading)
                            .animation(.easeInOut(duration: 0.4), value: self.lvm.showLoactionList)
                    }
            }
            if lvm.showLoactionList{
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
    
    private var mapPlayer: some View{
        //RandomAccessCollection: Idenfiable,Hashable
        Map(coordinateRegion: self.$lvm.mapRegion, annotationItems: lvm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates){
                LocationMapAnnotationView()
                    .scaleEffect(lvm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        lvm.locatedPlace(loaction: location)
                    }
            }
        })
    }
    
    private var LocationPreviewZstack: some View{
        ZStack{
            ForEach(lvm.locations){ location in
                if lvm.mapLocation == location{
                    LocationPreviewView(location: location)
                        .environmentObject(self.lvm)
                        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
                        .transition(.asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading)))
                }
               
            }
        }
    }
}
