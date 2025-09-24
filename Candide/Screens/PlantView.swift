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
    
    var activeTasks: [PlantTask] {
        taskList.taskList.filter { $0.plantID == plant.id && !$0.isDone }
    }

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
                                    .shadow(radius:5)
                                    .clipped()
                            } else {
                                if let image = plant.imageName {
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity, maxHeight: 256)
                                        .shadow(radius:5)
                                        .clipped()
                                }
                            }
                        } else {
                            Image("default")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 256)
                                .shadow(radius:5)
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
                                    .font(.headline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.cYellow)
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
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
                                .padding(.horizontal, 8)
                                .padding(.vertical, 16)
                                .background(Color.cYellow)
                                .cornerRadius(16)
                                .shadow(radius: 2)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 30)
                        }
                        
                        //  TASK PLANT
                        VStack {
                            HStack {
                                HStack {
                                    Text("Tâches: ")
                                        .font(.headline)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.cYellow)
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
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
                                        .font(.subheadline.bold())
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 2)
                                        .background(Color.cDarkBlue)
                                        .foregroundColor(.cOrange)
                                        .cornerRadius(16)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .sheet(isPresented: $showTask) {
                                        AddTaskView(plant: plant, navPath: $navPath)
                                    }
                                }
                            }
                            ScrollView(showsIndicators: false) {
                                ForEach(activeTasks) { myTask in
                                    PlantRowTask(myTask: myTask/*, isChange: $isChange*/)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, 6)
                                        .cornerRadius(12)
                                        .shadow(radius: 1)
                                        .padding(.horizontal, 10)
                                }
                                .padding(.vertical, 8)
                                .background(Color.cYellow)
                                .cornerRadius(16)
                                .shadow(radius: 2)

                            }
                            .frame(maxWidth: .infinity, maxHeight: 172)
                            .padding(.horizontal, 30)
                        }
                        .padding(.top, 16)
                        
                        //  NOTE
                        VStack {
                            HStack {
                                Text("Note: ")
                                    .font(.headline)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.cYellow)
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                                    .padding(.horizontal, 30)
                                    .shadow(radius: 2)
                                
                                Spacer()
                                
                            }
                            
                            TextEditor(text: $plant.note)
                                .scrollContentBackground(.hidden)
                                .padding()
                                .background(Color.cYellow)
                                .cornerRadius(16)
                                .shadow(radius: 2)
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
        plant: plantListGlobalVar.plantList[0],
        taskList: taskListGlobalVar,
        navPath: .constant(NavigationPath())
    )
}
