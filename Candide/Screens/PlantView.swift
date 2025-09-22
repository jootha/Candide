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
    @ObservedObject var taskList = taskListGlobalVar
    @Binding var navPath: NavigationPath
    @State var showingAlert = false
    @State var showingEditView = false
    @State var showTask = false
    
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
                
                //  BOUTTONS
                HStack {
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
                    
                    //  DELETE PLANT
                    Button {
                        showingAlert = true
                    } label: {
                        ZStack {
                            Circle().frame(width: 30)
                                .foregroundColor(.cDarkBlue)
                            
                            Image(systemName: "trash")
                                .opacity(0.8)
                                .foregroundColor(.cOrange)
                                .font(.system(size: 15))

                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Achtung!"),
                            message: Text("Etes-vous sûr de sûr de vouloir supprimer cette petite plante toute choupinou ?"),
                            primaryButton: .destructive(Text("Supprimer")) {
                                navPath.removeLast()
                                plantList.removePlant(plant)
                            },
                            secondaryButton: .cancel(Text("Annuler"))
                        )
                    }

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

                                if plant.isIndoor {
                                    PlantRowInfo(
                                        plantValue: "",
                                        plantText: "Interieur",
                                        plantIco: "💡"
                                    )
                                } else {
                                    PlantRowInfo(
                                        plantValue: "",
                                        plantText: "Extérieur",
                                        plantIco: "🌳"
                                    )
                                }

                            }
                            .padding(.vertical, 8)
                            .background(.cYellow)
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, minHeight: 192)
                        .padding(.horizontal, 30)
                    }
                    
                    //  TASK PLANT
                    VStack {
                        HStack {
                            Text("Tâches: ")
                                .padding(10)
                                .font(.subheadline)
                                .background(Color.cYellow)
                                .cornerRadius(16)
                                .padding(.horizontal, 30)
                                .shadow(radius: 2)
                            
                            Spacer()
                            
                            Button {
                                showTask = true
                            } label: {
                                Label("Plus", systemImage: "plus")
                                    .labelStyle(.iconOnly)
                                    .padding(16)
                                    .background(.cDarkBlue)
                                    .foregroundStyle(.cOrange)
                                    .cornerRadius(32)
                                    .font(.system(size: 32))
                                    .bold()
                            }
                            .offset(x: -24, y: 32)
                            .sheet(isPresented: $showTask) {
                                AddTaskView(plant: plant, navPath: $navPath)
                            }
                        }.zIndex(2)
                        
                        ScrollView(showsIndicators: false) {
                            ForEach(taskList.taskList) { myTask in
                                if plant.id == myTask.plantID {
                                    PlantRowAlert(myTask: myTask)
                                }

                            }
                            .zIndex(0)
                            .padding(.vertical, 8)
                            .background(.cYellow)
                            .cornerRadius(10)
                        }
                        .frame(minHeight: 64)
                        .padding(.horizontal, 30)
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


#Preview {
    PlantView(
        plant: plantListGlobalVar.plantList[0],
        taskList: taskListGlobalVar,
        navPath: .constant(NavigationPath())
    )
}
