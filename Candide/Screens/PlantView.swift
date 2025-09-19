//
//  PlantView.swift
//  Candide
//
//  Created by apprenant90 on 17/09/2025.
//

import SwiftUI

struct PlantView: View {
    
    @ObservedObject var plant: Plant
    @ObservedObject var plantList = plantListGlobalVar
    @Binding var navPath: [Plant]
    @State var task: [PlantTask] = tasks
    @State var showingAlert = false
    @State var showingEditView = false

    var body: some View {
        
        ZStack {
            
            Color.cGreen.ignoresSafeArea()
            
            VStack {
                
                //  IMAGE
                if let image = plant.imageName {
                    Image(image)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 256)
                    
                } else {
                    Image("default")
                        .resizable()
                }

                
                //  MODIF PLANT
                Button {
                    showingEditView.toggle()
                } label: {
                    Image(systemName: "pencil.circle")
                        .font(.title)
                }
                .sheet(isPresented: $showingEditView) {
                    EditPlantView(plant: plant)
                }
                .offset(x: 160, y: -235)
                .zIndex(2)


                VStack {
                    
                    //  INFORMATIONS
                    VStack {
                        
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
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, minHeight: 192)
                        .padding(.horizontal,30)
                        
                    }
                    
                    
                    //  TASK PLANT
                    VStack {
                        
                        HStack {
                            
                            Text("Alertes: ")
                                .padding(10)
                                .font(.subheadline)
                                .background(Color.cYellow)
                                .cornerRadius(16)
                                .padding(.horizontal, 30)
                                .shadow(radius: 2)
                            
                            Spacer()
                            
                            AddButton(action: "task").offset(x: -24, y: 32)
                            
                        }.zIndex(2)
                        
                        
                        ScrollView (showsIndicators: false) {
                            ForEach (tasks.indices, id: \.self) { index in
                                if plant.id == task[index].plantID {
                                    PlantRowAlert(task: $task[index])
                                }
                            }
                            .zIndex(0)
                            .padding(.vertical, 8)
                            .background(.cYellow)
                            .cornerRadius(10)
                        }
                        .frame(minHeight: 64)
                        .padding(.horizontal,30)
                        
                    }
                    
                    
                    //  DELETE PLANT
                    Button {
                        showingAlert = true
                    } label: {
                        ZStack {
                            Text("Supprimer une plante")
                                .foregroundColor(.cOrange)
                                .padding(16)
                                .background(.cDarkBlue)
                                .cornerRadius(10)
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Achtung!"),
                            message: Text("Etes-vous sûr de sûr de vouloir supprimer cette petite plante toute choupinou ?"),
                            primaryButton: .destructive(Text("Supprimer")) {
                                navPath.removeAll()
                                plantList.removePlant(plant)
                            },
                            secondaryButton: .cancel(Text("Annuler"))
                        )
                    }
                    
                }
                
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(plant.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(.cDarkBlue, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
    }
}

#Preview { PlantView(plant: plantListGlobalVar.plantList[0], navPath: .constant([])) }
