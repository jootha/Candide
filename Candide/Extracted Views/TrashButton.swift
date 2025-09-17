//
//  TrashButton.swift
//  Candide
//
//  Created by apprenant84 on 16/09/2025.
//

import SwiftUI

struct TrashButton: View {

    @State var plant: Plant
@ObservedObject var plantsList = listPlant
    var body: some View {
        Button {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                plantsList.listPlants.remove(at: index)
            }
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
    TrashButton(plant: plants[2])
}
