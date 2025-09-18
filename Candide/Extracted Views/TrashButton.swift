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
    @State var showingAlert = false
    
    //@State var presentAlert : Binding<Bool>
    
    var body: some View {
        Button {
            showingAlert = true
            
        } label: {
            ZStack {  //Bouton edit
                Circle().frame(width: 30)
                    .foregroundColor(.cDarkBlue)
                Image(systemName: "trash")
                    .opacity(0.8)
                    .foregroundColor(.cOrange)
                    .font(.system(size: 15))
            }
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Supprimer !"),
                message: Text("Etes-vous sûr de vouloir supprimer " + plant.name + " ?"),
                primaryButton: .destructive(Text("Supprimer")) {
                    plantList.removePlant(plant)
                },
                secondaryButton: .cancel(Text("Annuler"))
            )
        }
      }
    }


#Preview {
    TrashButton(plant: plantListGlobalVar.plantList[2])
}
