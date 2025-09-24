//
//  AddPlantView.swift
//  Candide
//
//  Created by apprenant90 on 16/09/2025.
//

import SwiftUI

struct AddPlantView: View {
    @State private var name: String = ""
    @State private var soilType: SoilType = .wellDrained
    @State private var watering: WateringFrequency = .daily
    @State private var sunlight: Sunlight = .fullSun
    @State private var isIndoor: Bool = true
    @Binding var navPath: NavigationPath
    var onSave: (Plant) -> Void

    @StateObject var photoViewModel = PhotoViewModel()
    @State private var showCamera = false
    @State private var selectedPhoto: UIImage? = nil
    @State private var showFullScreen = false

    var body: some View {
        
            ZStack {
                Form {
                    VStack {
                        TextField("**Nom**", text: $name)
                        //  IMAGES??t???
                        Picker("Ensoleillement", selection: $sunlight) {
                            ForEach(Sunlight.allCases, id: \.self) { light in
                                Text(light.rawValue)
                            }
                        }
                        Picker("Type de sol", selection: $soilType) {
                            ForEach(SoilType.allCases, id: \.self) { soil in
                                Text(soil.rawValue)
                            }
                        }
                        Picker("Arrosage", selection: $watering) {
                            ForEach(WateringFrequency.allCases, id: \.self) {
                                water in
                                Text(water.rawValue)
                            }
                        }
                        Toggle("En Interieur?", isOn: $isIndoor)
                        if let image = photoViewModel.photo {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350, height: 350)
                                .clipped()
                                .cornerRadius(12)
                                .onTapGesture {
                                    selectedPhoto = photoViewModel.photo
                                    showFullScreen = true
                                }
                        }
                        
                    }
                    .scrollContentBackground(.hidden)
                    .background(
                        Color.cYellow.opacity(0.3),
                        in: RoundedRectangle(cornerRadius: 12)
                    )
                    if selectedPhoto != nil {
                        Image(uiImage: selectedPhoto!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 1, height: 1)
                    }
                    //Ajout Image
                    HStack{
                        
                        Spacer()
                        Button {
                            showCamera = true
                        } label: {
                            Label("Plus", systemImage: "photo")
                                .labelStyle(.iconOnly)
                                .padding(16)
                                .background(.cDarkBlue)
                                .foregroundStyle(.cOrange)
                                .cornerRadius(32)
                                .font(.system(size: 32))
                                .bold()
                        }.sheet(isPresented: $showCamera) {
                            CameraScreen(viewModel: photoViewModel)
                        }
                        Spacer()
                    }
                }
                
            }
           
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Enregistrer") {
                    let newPlant = Plant(
                        name: name,
                        imageName: globalLastPhotoTaken.isEmpty ? nil : globalLastPhotoTaken,
                        soilType: soilType,
                        watering: watering,
                        sunlight: sunlight,
                        isIndoor: isIndoor,
                        note: "..."
                    )

                    onSave(newPlant)
                    globalLastPhotoTaken = ""
                    navPath.removeLast()
                }
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .fullScreenCover(isPresented: $showFullScreen) {
            if selectedPhoto != nil {
                ZStack {
                    Color.black.ignoresSafeArea()
                    Image(uiImage: selectedPhoto!)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                showFullScreen = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                }
            } else {
                Text("Pas d'image")
            }
        }
        .navigationTitle("Nouvelle plante")
    }
}

#Preview {
    NavigationStack {
        AddPlantView(navPath: .constant(NavigationPath())) { plant in
            print("Preview: a plant named '\(plant.name)'")
        }
    }
}
