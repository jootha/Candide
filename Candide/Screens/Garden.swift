//
//  Garden.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//

import SwiftUI

struct Garden: View {
    @ObservedObject var plantListLocalVar = plantListGlobalVar

    var body: some View {

        NavigationStack {
            ZStack {
                Color.cGreen.ignoresSafeArea()
                
                ScrollView {
                    ForEach(plantListGlobalVar.plantList){ plant in
                        GardenPlanteFrame(plant : plant, plantList: plantListLocalVar)
                    }.navigationTitle("Mon jardin")
                    
                }.padding(.horizontal)
            }
        }
        
    }
}

#Preview {
    Garden()
}
