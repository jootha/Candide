//
//  GardenPlanteFrame.swift
//  Candide
//
//  Created by apprenant84 on 16/09/2025.
//

import SwiftUI

struct GardenPlanteFrame: View {
    var plant: Plant
    @ObservedObject var plantList: PlantListClass

    var body: some View {
        HStack {
            ZStack {
                NavigationLink {
                    AddPlantView()
                } label: {
                    if let image = plant.imageName {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .padding(-8)
                            .overlay(alignment: .topTrailing) {
                                TrashButton(plant: plant)
                            }
                    } else {
                        Image("default")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .padding(-8)
                            //.offset(x: -100, y: 50)
                            .overlay(alignment: .topTrailing) {
                                TrashButton(plant: plant, plantList: plantList)
                            }
                    }
                    //Text(plant.name).font(.system(size: 24)).bold()
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.cYellow)
            .cornerRadius(16)
    }
}

#Preview {
    GardenPlanteFrame(plant: plantListGlobalVar.plantList[0], plantList: plantListGlobalVar)
}
