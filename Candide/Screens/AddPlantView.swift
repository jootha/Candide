//
//  AddPlantView.swift
//  Candide
//
//  Created by apprenant90 on 16/09/2025.
//

import SwiftUI

struct AddPlantView: View {
    @State private var name: String = ""
    @State private var soilType: SoilType = .wellDrained
    @State private var watering: WateringFrequency = .daily
    @State private var sunlight: Sunlight = .fullSun
    @State private var isIndoor: Bool = true
    @Binding var navPath: NavigationPath
    var onSave: (Plant) -> Void

    var body: some View {
        Form {
            TextField("**Nom**", text: $name)

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

        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Enregistrer") {
                    let newPlant = Plant(
                        name: name,
                        soilType: soilType,
                        watering: watering,
                        sunlight: sunlight,
                        isIndoor: isIndoor
                    )

                    onSave(newPlant)
                    navPath.removeLast()
                }
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .navigationTitle("Nouvelle plante")
    }
}

#Preview {
    NavigationStack {
        AddPlantView(navPath: .constant(NavigationPath())) { plant in
            print("Preview: a plant named '\(plant.name)'")
        }
    }
}
