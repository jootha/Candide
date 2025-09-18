//
//  Garden.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//

import SwiftUI

struct Garden: View {
    @ObservedObject var plantListLocalVar = plantListGlobalVar
    @State var navPath = [Plant]()

    var body: some View {

        NavigationStack(path: $navPath) {
            
            ZStack {
                Color.cGreen.ignoresSafeArea()
                
                ScrollView {
                    ForEach(plantListGlobalVar.plantList){ plant in
                        Button {
                            navPath.append(plant)
                        } label: {
                            GardenPlanteFrame(plant : plant)
                        }
                    }.padding(.vertical)
                }.padding(.horizontal)
                
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        AddButton(action: "garden")
                            .padding()
                    }
                }
                
            }
            .navigationDestination(for: Plant.self){ plant in
                PlantView(plant: plant, navPath: $navPath)
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Mon jardin")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
        .toolbarBackground(.cDarkBlue, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        }
        
    }
}

#Preview {
    Garden()
}
