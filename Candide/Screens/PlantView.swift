//
//  PlantView.swift
//  Candide
//
//  Created by apprenant90 on 17/09/2025.
//

import SwiftUI

struct PlantView: View {
    
    var plant: Plant
    @ObservedObject var plantList = plantListGlobalVar
    @Binding var navPath: [Plant]

    var body: some View {

            ZStack {

                Color.cDarkBlue.ignoresSafeArea()

                Rectangle().foregroundStyle(.cGreen)

                VStack {

//                  IMAGE
                    if let image = plant.imageName {
                        Image(image).resizable()
                    } else {
                        Image("default").resizable()
                    }

                    VStack {
//                      INFORMATIONS
                        HStack {

                            Text("Informations: ")
                                .padding(10)
                                .font(.subheadline)
                                .background(Color.cYellow)
                                .cornerRadius(16)
                                .padding(.horizontal, 30)
                                .shadow(radius: 2)

                            Spacer()

                        }

                        ScrollView(showsIndicators: false) {
                            VStack {
                                PlantRowInfo(
                                    plantValue: "\(plant.sunlight.rawValue)",
                                    plantText: "Ensoleillement",
                                    plantIco: "☀️"
                                )
                                
                                PlantRowInfo(
                                    plantValue: "\(plant.watering.rawValue)",
                                    plantText: "Arrosage",
                                    plantIco: "💧"
                                )
                                
                                PlantRowInfo(
                                    plantValue: "\(plant.soilType.rawValue)",
                                    plantText: "Type de sol",
                                    plantIco: "🪴"
                                )

                            }
                            .padding(.vertical, 8)
                            .background(.cYellow)

                        }
                        .padding(.horizontal,30)
                        
//                      ALERTES PLANT
                        HStack {

                            Text("Alertes: ")
                                .padding(10)
                                .font(.subheadline)
                                .background(Color.cYellow)
                                .cornerRadius(16)
                                .padding(.horizontal, 30)
                                .shadow(radius: 2)

                            Spacer()

                        }

                        ScrollView (showsIndicators: false){
                            ForEach (tasks.indices, id: \.self) { index in
                                //ProgramRow(task: tasks[index], plant: plantListGlobalVar.plantList[index])
                            } .padding(.vertical,8)
                            
                        }
                        .padding(.horizontal,30)

//                      BUTTONS
                        VStack {
                            
//                          MODIF PLANT
                            Button {
                                
                            } label: {
                                ZStack {
                                    Text("Modifier une plante")
                                        .foregroundColor(.white)
                                }
                            }
                            
    //                      REMOVE PLANT
                            Button {
                                navPath.removeAll()
                                plantList.removePlant(plant)
                            } label: {
                                ZStack {
                                    Text("Supprimer une plante")
                                        .foregroundColor(.cOrange)
                                }
                            }

                        }

                    }
                }
                
            }
//            .navigationTitle(plant.name)

//                            .background(Color.cYellow)
//                            .cornerRadius(10)
        }
//    }
}

#Preview {
        PlantView(plant: plantListGlobalVar.plantList[0], navPath: .constant([]))
//    PlantView(plant: plantListGlobalVar.plantList[1], navPath: <#Binding<[Plant]>#>)
}
