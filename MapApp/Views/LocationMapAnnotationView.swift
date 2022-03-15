//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by i564206 on 2022/3/15.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "map.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.red)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.red)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                
        }
        
            
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotationView()
    }
}
