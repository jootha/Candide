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
                    default:
                    AddPostView()
                }

            } label: {

                Label("Plus", systemImage: "plus")
                    .labelStyle(.iconOnly)
                    .padding(8)
                    .background(.cDarkBlue)
                    .foregroundStyle(.cPink)
                    .cornerRadius(128)
                    .font(.system(size: 64))
                    .bold()
                }
                
            }
    
}

#Preview {
    AddButton(action: "post")
}
