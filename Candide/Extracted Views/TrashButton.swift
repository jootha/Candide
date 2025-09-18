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
    //@State var presentAlert : Binding<Bool>
    
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
        }/*.alert(isPresented: $presentAlert) {
            Alert(title: Text("Supprimer la plant ?"), message: Text("Etes vous sûr de vouloir supprimer la " + plant.name + " ?"), primaryButton: .default(Text("oui")), secondaryButton: .cancel(Text("non")))
      }*/
    }
}

#Preview {
    TrashButton(plant: plantListGlobalVar.plantList[2])
}
