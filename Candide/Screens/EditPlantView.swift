//
//  EditPlantView.swift
//  Candide
//
//  Created by Flood on 18/09/2025.
//

import SwiftUI

struct EditPlantView: View {
    @ObservedObject var plant: Plant
    @FocusState private var isTextFieldFocused: Bool
    @State var tmpPlantName: String
    @State var selectedSoil: SoilType = .wellDrained
    @State var selectedSunLight: Sunlight = .fullSun
    @State var selectedWatering: WateringFrequency = .daily
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                Color.cGreen.ignoresSafeArea()
                
                ZStack {
                    Form {
                        TextField("**Nom**", text: $tmpPlantName)
                            .focused($isTextFieldFocused)
                            .onAppear {self.isTextFieldFocused = true}
                        
                        //  IMAGES??t???
                        
                        Picker("Ensoleillement", selection: $plant.sunlight) {
                            ForEach(Sunlight.allCases, id: \.self) { light in
                                Text(light.rawValue)
                            }
                        }
                        
                        Picker("Sol", selection: $plant.soilType) {
                            ForEach(SoilType.allCases, id: \.self) { soil in
                                Text(soil.rawValue)
                            }
                        }
                        
                        Picker("Arrosage", selection: $plant.watering) {
                            ForEach(WateringFrequency.allCases, id: \.self) { soil in
                                Text(soil.rawValue)
                            }
                        }
                        
                        Toggle("En Interieur?", isOn: $plant.isIndoor)
                        
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        plant.name = tmpPlantName
                        plant.soilType = selectedSoil
                        plant.watering = selectedWatering
                        plant.sunlight = selectedSunLight
                        dismiss()
                    }
                    .disabled(plant.name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .tint(.white)
                }
            }
        }
    }
}

#Preview {EditPlantView(plant: plantListGlobalVar.plantList[0], tmpPlantName: plantListGlobalVar.plantList[0].name)}
