//
//  AddButton.swift
//  Candide
//
//  Created by apprenant90 on 16/09/2025.
//

import SwiftUI

struct AddButton: View {
    @State var action: String
    @Binding var navPath: NavigationPath

    var body: some View {
        Button {
            switch action {
            case "post":
                navPath.append(1)
            default:
                navPath.append(3)
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
        .navigationDestination(for: Int.self) { index in
            switch index {
            case 1:
                AddPostView()
            default:
                AddPlantView(navPath: $navPath) { newPlant in
                    plantListGlobalVar.plantList.insert(newPlant, at: 0)
                }
            }
        }
    }
}

#Preview { AddButton(action: "post", navPath: .constant(NavigationPath())) }
