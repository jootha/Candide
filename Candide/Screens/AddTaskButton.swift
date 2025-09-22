//
//  AddTaskButton.swift
//  Candide
//
//  Created by apprenant90 on 20/09/2025.
//

import SwiftUI

struct AddTaskButton: View {
    @ObservedObject var plant: Plant
    @Binding var navPath: NavigationPath

    var body: some View {
        Button {
            navPath.append(plant)
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
        .navigationDestination(for: Plant.self) { plant in
            AddTaskView(plant: plant, navPath: $navPath)
        }
    }
}

#Preview {
    AddTaskButton(
        plant: plantListGlobalVar.plantList[0],
        navPath: .constant(NavigationPath())
    )
}
