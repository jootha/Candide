//
//  GardenPlanteFrame.swift
//  Candide
//
//  Created by apprenant84 on 16/09/2025.
//

import SwiftUI

struct GardenPlanteFrame: View {
    var plant: Plant

    var body: some View {
        HStack {
            ZStack {  //Carte rose avec image
                if(!plant.imageName.isEmpty){
                    Image(plant.imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .padding(-8)
                        .shadow(radius: 5)
                        .overlay(alignment: .topTrailing) {
                            TrashButton(plant: plants[0])
                        }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.cYellow)
            .cornerRadius(16)
    }
}
#Preview {
    GardenPlanteFrame(plant: plants[3])
}
