//
//  LocationListView.swift
//  MapApp
//
//  Created by i564206 on 2022/3/14.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject var lvm: LocationsViewModel
    
    var body: some View {
        List{
            ForEach(lvm.locations){ location in
                Button(action: {
                    lvm.locatedPlace(loaction: location)
                }){
                    HStack{
                        if let imageName = location.imageNames.first{
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45,height: 45)
                                .cornerRadius(10)
                        }
                        
                        VStack{
                            Text(location.name)
                                .font(.headline)
                            Text(location.cityName)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)

                    }
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationsViewModel())
    }
}
