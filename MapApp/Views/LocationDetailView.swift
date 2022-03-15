//
//  LocationDetailView.swift
//  MapApp
//
//  Created by i564206 on 2022/3/15.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @Binding var ifShowDetail: Bool
    let location: Location
    
    var body: some View {
        ScrollView{
            imageView
                .frame(height: UIScreen.main.bounds.height / 2)
                .tabViewStyle(PageTabViewStyle())
                
            
            titleView
            
            Divider()
            
            descriptionView
                .padding(.top)
            
            Divider()
            
            mapLayer
            
        }
        .edgesIgnoringSafeArea(.top)
        .background(.ultraThinMaterial)
        
        
        
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(ifShowDetail: .constant(false), location: LocationsDataService.locations[0])
    }
}

extension LocationDetailView{
    private var imageView: some View{
        VStack{
            TabView {
                ForEach(location.imageNames, id: \.self){ imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width)
                        .clipped()
                        
                }
            }
            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 10)
            
            Spacer()
        }
    }
    
    private var titleView: some View{
        HStack {
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(location.cityName)
                    .font(.title3)
                    .foregroundColor(.secondary)
                
            }
            
            Spacer()
        }
        .padding(10)
        .overlay(alignment: .trailing) {
            Button {
                self.ifShowDetail = false
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(16)
                    .foregroundColor(.primary)
                    .background(.thickMaterial)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding(10)

        }
    }
    
    private var descriptionView: some View{
        VStack(alignment: .leading, spacing: 30){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.black)
                .lineSpacing(10)
            
            if let url = URL(string: location.link){
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
        .padding([.trailing,.leading])
    }
    
    private var mapLayer: some View{
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))), annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
        //the map can't move
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }
}
