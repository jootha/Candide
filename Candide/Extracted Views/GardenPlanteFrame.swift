//
//  GardenPlanteFrame.swift
//  Candide
//
//  Created by apprenant84 on 16/09/2025.
//

import SwiftUI

struct GardenPlanteFrame: View {
    @ObservedObject var plant: Plant

    var body: some View {

        ZStack {
            if let name = plant.imageName {
                let url = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
                    .appendingPathComponent(name)
                
                if let uiImage = UIImage(contentsOfFile: url.path) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width:370, height:250)
                        .clipped()
                        .cornerRadius(16)
                        .padding(-8)
                        .overlay(alignment: .topTrailing) {
                            TrashButton(plant: plant)
                        }
                } else {
                    if let image = plant.imageName {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width:370, height:250)
                            .clipped()
                            .cornerRadius(16)
                            .padding(-8)
                            .overlay(alignment: .topTrailing) {
                                TrashButton(plant: plant)
                            }

                    }
                }

            } else {
                Image("default")
                    .resizable()
                    .scaledToFill()
                    .frame(width:370, height:250)
                    .clipped()
                    .cornerRadius(16)
                    .padding(-8)
                    //.offset(x: -100, y: 50)
                    .overlay(alignment: .topTrailing) {
                        TrashButton(
                            plant: plant
                        )
                    }
            }
            HStack {
                VStack {
                    Text(plant.name).font(.system(size: 16)).bold()
                        .foregroundStyle(.cDarkBlue)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(16)
                    Spacer()
                }
                if let imageName = plant.imageName {
                    Text(imageName).font(.system(size: 16)).bold()
                        .foregroundStyle(.cDarkBlue)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(16)
                    Spacer()
                }
               
            }

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.cYellow)
            .cornerRadius(16)

    }
}

#Preview {
    GardenPlanteFrame(plant: plantListGlobalVar.plantList[1])
}
