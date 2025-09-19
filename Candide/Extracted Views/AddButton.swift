//
//  AddButton.swift
//  Candide
//
//  Created by apprenant90 on 16/09/2025.
//

import SwiftUI

struct AddButton: View {
    @State var action: String
    @State var taptap = false

    var body: some View {
        
            NavigationLink {
                
                switch action {
                    case "post":
                        AddPostView()
                case "Garden" :
                    AddPlantView(plant: defaultPlant)
                    default:
                        AddPlantView(plant: defaultPlant)
                }

            } label: {

                Label("Plus", systemImage: "plus")
                    .labelStyle(.iconOnly)
                    .padding(16)
                    .background(.cDarkBlue)
                    .foregroundStyle(.cOrange)
                    .cornerRadius(32)
                    .font(.system(size: 32))
                    .bold()
                }
                
            }
    
}

#Preview {
    AddButton(action: "post")
}
