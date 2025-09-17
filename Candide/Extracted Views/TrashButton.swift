//
//  TrashButton.swift
//  Candide
//
//  Created by apprenant84 on 16/09/2025.
//

import SwiftUI

struct TrashButton: View {

    @State var plant: Plant
    @ObservedObject var plantList = plantListGlobalVar
    
    var body: some View {
        Button {
            plantList.printPlantListNames()
            plantList.removePlant(plant)

            
            plantList.printPlantListNames()
        } label: {
            ZStack {  //Bouton edit
                Circle().frame(width: 30)
                    .foregroundColor(.cDarkBlue)
                Image(systemName: "trash")
                    .opacity(0.8)
                    .foregroundColor(.cOrange)
                    .font(.system(size: 15))
            }
        }
    }
}

#Preview {
    TrashButton(plant: plantListGlobalVar.plantList[2])
}
