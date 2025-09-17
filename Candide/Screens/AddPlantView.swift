//
//  AddPlantView.swift
//  Candide
//
//  Created by apprenant90 on 16/09/2025.
//

import SwiftUI

struct AddPlantView: View {
    @ObservedObject var plant : Plant
    
    var body: some View {
        Text("Vue PLant")
        TextField("User name (email address)", text: $plant.name)
        
        Text(plant.name)
    }
}

#Preview {
    AddPlantView(plant: plantListGlobalVar.plantList[0])
}
