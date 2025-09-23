//
//  AddPlantView.swift
//  Candide
//
//  Created by apprenant90 on 16/09/2025.
//

import SwiftUI

struct AddPlantView: View {
    @FocusState private var isTextFieldFocused: Bool
    @State private var name: String = ""
    @State private var soilType: SoilType = .wellDrained
    @State private var watering: WateringFrequency = .daily
    @State private var sunlight: Sunlight = .fullSun
    @State private var isIndoor: Bool = true
    @Binding var navPath: NavigationPath
    var onSave: (Plant) -> Void

    
    @StateObject var photoViewModel = PhotoViewModel()
    @State private var showCamera = false


    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
            ZStack {
                Form {
                    VStack {
                        TextField("**Nom**", text: $name)
                            .focused($isTextFieldFocused)
                            .onAppear {self.isTextFieldFocused = true}
                        
                        //  IMAGES??t???
                        
                        Picker("Ensoleillement", selection: $sunlight) {
                            ForEach(Sunlight.allCases, id: \.self) { light in
                                Text(light.rawValue)
                            }
                        }
                        
                        Picker("Type de sol", selection: $soilType) {
                            ForEach(SoilType.allCases, id: \.self) { soil in
                                Text(soil.rawValue)
                            }
                        }
                        
                        Picker("Arrosage", selection: $watering) {
                            ForEach(WateringFrequency.allCases, id: \.self) { water in
                                Text(water.rawValue)
                            }
                        }
                        
                        Toggle("En Interieur?", isOn: $isIndoor)
                        
                        ForEach(photoViewModel.photos.indices, id: \.self) { index in
                            Image(uiImage: photoViewModel.photos[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(12)
                        }
                    }
                    .background(Color.cYellow.opacity(0.3), in: RoundedRectangle(cornerRadius: 12))
                }.scrollContentBackground(.hidden)

            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        let newPlant = Plant(
                            name: name,
                            soilType: soilType,
                            watering: watering,
                            sunlight: sunlight,
                            isIndoor: isIndoor,
                            note:"..."
                        )
                        
                        onSave(newPlant)
                        navPath.removeLast()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .tint(.white)

                }

            }
            .navigationTitle("Nouvelle plante")
            
            //Ajout Image
            Button{
                showCamera = true
            } label: {
                Label("Plus", systemImage: "photo")
                    .labelStyle(.iconOnly)
                    .padding(16)
                    .background(.cDarkBlue)
                    .foregroundStyle(.cOrange)
                    .cornerRadius(32)
                    .font(.system(size: 32))
                    .bold()
            }.sheet(isPresented: $showCamera) {
                CameraScreen(viewModel: photoViewModel)
            }
        }
        .background(Color.cGreen)
    }
}

#Preview {
    NavigationStack {
        AddPlantView(navPath: .constant(NavigationPath())) { plant in
            print("Preview: a plant named '\(plant.name)'")
        }
    }
}
