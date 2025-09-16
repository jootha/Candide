//
//  Garden.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//

import SwiftUI

struct Garden: View {
    
    var body: some View {

        NavigationStack {
            ZStack {
                Color.cGreen.ignoresSafeArea()
                
                ScrollView {
                    ForEach(plants){ plant in
                        GardenPlanteFrame(plant : plant)
                    }.navigationTitle("Mon jardin")
                    
                }.padding(.horizontal)
            }
        }
        
    }
}

#Preview {
    Garden()
}
