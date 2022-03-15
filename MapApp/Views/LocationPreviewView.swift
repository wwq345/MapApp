//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by i564206 on 2022/3/14.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var lvm: LocationsViewModel
    @State var ifShowDetail: Bool = false
    let location: Location
    
    var body: some View {
        HStack(alignment:.bottom){
            VStack(alignment: .leading){
                image
                    .padding(6)
                    .background(.white)
                    .cornerRadius(20)
               
                name
                
            }
            .padding(.leading)
            
            
            
            VStack{
               learnMoreBtn
 
               nextCityBtn
                
            }
            .padding(.trailing)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 40)
        )
        .cornerRadius(20)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations[4])
                .environmentObject(LocationsViewModel())
        }
    }
}

extension LocationPreviewView{
    private var image: some View{
        ZStack{
//            if let imageName = self.lvm.locations[0].imageNames.first{
            if let imageName = self.location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100,height: 100)
                    .cornerRadius(10)
                
            }
        }
    }
    
    private var name: some View{
        VStack(alignment: .leading, spacing: 5){
//            Text(self.lvm.locations[0].name)
            Text(self.location.name)
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 165, alignment: .leading)
                
            
//            Text(self.lvm.locations[0].cityName)
            Text(self.location.cityName)
                .font(.subheadline)

                
        }
        .padding(.trailing, 20)
    }
    
    private var learnMoreBtn: some View{
        Button(action: {
            self.ifShowDetail = true
        }){
            Text("Learn More")
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: self.$ifShowDetail, onDismiss: {}) {
            LocationDetailView(ifShowDetail: self.$ifShowDetail, location: self.location)
        }
    }
    
    private var nextCityBtn: some View{
        Button(action: {
            lvm.nextLocation()
        }){
            Text("Next City")
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
