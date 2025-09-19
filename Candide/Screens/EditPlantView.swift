//
//  EditPlantView.swift
//  Candide
//
//  Created by Flood on 18/09/2025.
//

import SwiftUI

struct EditPlantView: View {

    @ObservedObject var plant: Plant
    @State var tmpPlantName: String = plantListGlobalVar.plantList[0].name
    @State var selectedSoil: SoilType = .wellDrained
    @State var selectedSunLight: Sunlight = .fullSun
    @State var selectedWatering: WateringFrequency = .daily

    @Environment(\.dismiss) var dismiss

    var body: some View {
        
            NavigationView {
                
                Form {
                    
                    TextField("**Nom**", text: $plant.name)
                    //  IMAGES??t???

                    Picker("Ensoleillement", selection: $selectedSunLight) {
                        ForEach(Sunlight.allCases, id: \.self) { light in
                            Text(light.rawValue)
                        }
                    }
                    
                    
                    Picker("Type de sol", selection: $selectedSoil) {
                        ForEach(SoilType.allCases, id: \.self) { soil in
                            Text(soil.rawValue)
                        }
                    }
                    
                    
                    Picker("Arrosage", selection: $selectedWatering) {
                        ForEach(WateringFrequency.allCases, id: \.self) { soil in
                            Text(soil.rawValue)
                        }
                    }
                }
//                .navigationTitle("\(plant.name)")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Annuler") {
                            plant.name = tmpPlantName
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Enregistrer") {
                            plant.soilType = selectedSoil
                            plant.watering = selectedWatering
                            plant.sunlight = selectedSunLight
                            dismiss()
                        }
                    }
                }
                
            
        }

        
    }
    
}

#Preview {
//        EditPlantView(
//            plant: plantListGlobalVar.plantList[0],
//            tmpPlantName: plantListGlobalVar.plantList[0].name
//        )
//    
    EditPlantView(plant: plantListGlobalVar.plantList[0])
}
