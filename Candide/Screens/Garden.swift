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
    @State var searchText: String = ""

    var filteredData: [Plant] {
        return searchText.isEmpty
        ? plantListLocalVar.plantList
            : plantListLocalVar.plantList.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
    }

    var body: some View {

        NavigationStack(path: $navPath) {

            ZStack {
                Color.cGreen.ignoresSafeArea()

                ScrollView {
                    ForEach(filteredData) { plant in
                        Button {
                            navPath.append(plant)
                        } label: {
                            GardenPlanteFrame(plant: plant)
                        }
                    }.searchable(text: $searchText, prompt: "Rechercher...") {}
                        .padding(.vertical)

                }.padding(.horizontal)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            CameraScreen()
                        }label :{
                            Label("Plus", systemImage: "photo")
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

            }
            .navigationDestination(for: Plant.self) { plant in
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
