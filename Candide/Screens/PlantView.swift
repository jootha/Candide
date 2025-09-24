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

            ScrollView {
                VStack {
                    ZStack {
                        if let name = plant.imageName {
                            let url = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
                                .appendingPathComponent(name)
                            
                            if let uiImage = UIImage(contentsOfFile: url.path) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 256)
                                    .clipped()
                            } else {
                                if let image = plant.imageName {
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: 256)
                                        .clipped()

                                }
                            }

                        } else {
                            Image("default")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 256)
                                .clipped()
                        }
                    }
                    .overlay(alignment: .bottomLeading) {
                        //  BOUTTONS
                        HStack {
                            Spacer ()
            
                            //  MODIF PLANT
                            Button {
                                showingEditView.toggle()
                            } label: {
                                ZStack {
                                    Circle().frame(width: 48)
                                        .foregroundColor(.cDarkBlue)
                                    
                                    Image(systemName: "pencil.circle")
                                        .opacity(0.8)
                                        .foregroundColor(.cOrange)
                                        .font(.system(size: 24))
                                }
                            }
                            .sheet(isPresented: $showingEditView) {
                                EditPlantView(plant: plant, tmpPlantName: plant.name)
                            }
                            
                            //  DELETE PLANT
                            Button {
                                showingAlert = true
                            } label: {
                                ZStack {
                                    Circle().frame(width: 48)
                                        .foregroundColor(.cDarkBlue)
                                    
                                    Image(systemName: "trash")
                                        .opacity(0.8)
                                        .foregroundColor(.cOrange)
                                        .font(.system(size: 24))
                                    
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
                        .padding()

                        Spacer()
                    }
                    
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
                            .padding(.top, 16)

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
                                        plantText: "Sol",
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
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 30)
                        }
                        
                        //  TASK PLANT
                        VStack {
                            HStack {
                                HStack {
                                    Text("Tâches: ")
                                        .padding(10)
                                        .font(.subheadline)
                                        .background(Color.cYellow)
                                        .cornerRadius(16)
                                        .padding(.horizontal, 30)
                                        .shadow(radius: 2)
                                    
                                }

                                HStack() {
                                    Button {
                                        showTask = true
                                    } label: {
                                        HStack {
                                            
                                            Text("Ajouter une tâche")
                                            
                                            ZStack {
                                                
                                                Circle().frame(width: 30)
                                                    .foregroundColor(.cDarkBlue)
                                                
                                                Image(systemName: "plus")
                                                    .opacity(0.8)
                                                    .foregroundColor(.cOrange)
                                                    .font(.system(size: 15))
                                            }
                                            
                                        }
                                        .padding(.horizontal, 16)
                                        .background(.cDarkBlue)
                                        .foregroundStyle(.cOrange)
                                        .cornerRadius(16)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .sheet(isPresented: $showTask) {
                                        AddTaskView(plant: plant, navPath: $navPath)
                                    }
                                }
                            }
                            ScrollView(showsIndicators: false) {
                                ForEach(taskList.taskList) { myTask in
                                    if plant.id == myTask.plantID {
                                        PlantRowTask(myTask: myTask)
                                    }
                                }
                                .padding(.vertical, 8)
                                .background(.cYellow)
                                .cornerRadius(10)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 172)
                            .padding(.horizontal, 30)
                        }
                        .padding(.top, 16)

                        //  NOTE
                        VStack {
                            HStack {
                                Text("Note: ")
                                    .padding(10)
                                    .font(.subheadline)
                                    .background(Color.cYellow)
                                    .cornerRadius(16)
                                    .padding(.horizontal, 30)
                                    .shadow(radius: 2)
                                
                                Spacer()

                            }
                            
                            TextEditor(text: $plant.note)
                                .scrollContentBackground(.hidden)
                                .background(Color.cYellow)
                                .cornerRadius(10)
                                .padding()
                                .frame(height: 200)
                                .padding(.horizontal, 30)

                            Spacer()

                        }
                        .padding(.top, 16)

                    }
                }
            }
            .padding(.top, 0)

        }
        .navigationTitle(plant.name)
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
        plant: plantListGlobalVar.plantList[2],
        taskList: taskListGlobalVar,
        navPath: .constant(NavigationPath())
    )
}
