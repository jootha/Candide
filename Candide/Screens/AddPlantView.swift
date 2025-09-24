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
            Color.cGreen.ignoresSafeArea()

            VStack {
                HStack {
                    Text("Informations: ")
                        .font(.headline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.cYellow)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .padding(.horizontal, 30)
                        .shadow(radius: 2)

                    Spacer()
                }
                .padding(.top, 16)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Nom de la tâche")
                            .font(.headline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.cYellow)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        
                        TextField("**Nom**", text: $name)
                            .padding()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.cPink)
                            .cornerRadius(8)
                            .foregroundStyle(.cDarkBlue)
                            .padding(.horizontal, 30)
                        
                        Text("Ensoleillement")
                            .font(.headline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.cYellow)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        Picker("Ensoleillement", selection: $sunlight) {
                            ForEach(Sunlight.allCases, id: \.self) { light in
                                Text(light.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.cPink)
                        .cornerRadius(8)
                        .foregroundStyle(.cDarkBlue)
                        .padding(.horizontal, 30)

                        Text("Type de sol")
                            .font(.headline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.cYellow)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                         
                        Picker("Type de sol", selection: $soilType) {
                            ForEach(SoilType.allCases, id: \.self) { soil in
                                Text(soil.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.cPink)
                        .cornerRadius(8)
                        .foregroundStyle(.cDarkBlue)
                        .padding(.horizontal, 30)
                        
                        Text("Arrosage")
                            .font(.headline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.cYellow)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        
                        Picker("Arrosage", selection: $watering) {
                            ForEach(WateringFrequency.allCases, id: \.self) {
                                water in
                                Text(water.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.cPink)
                        .cornerRadius(8)
                        .foregroundStyle(.cDarkBlue)
                        .padding(.horizontal, 30)

                        Toggle("En intérieur ?", isOn: $isIndoor)
                            .padding()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.cPink)
                            .cornerRadius(8)
                            .foregroundStyle(.cDarkBlue)
                            .padding(.horizontal, 30)

                        if let uiImage = photoViewModel.photo {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 350)
                                .clipped()
                                .cornerRadius(12)
                                .onTapGesture {
                                    selectedPhoto = uiImage
                                    showFullScreen = true
                                }
                        }
                        if selectedPhoto != nil {
                            Image(uiImage: selectedPhoto!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 1, height: 1)
                        }

                        HStack {
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
                            }
                            .sheet(isPresented: $showCamera) {
                                CameraScreen(viewModel: photoViewModel)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 20)
                    }
                    .padding(.vertical, 16)
                    .background(Color.cYellow)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    .padding(.horizontal, 30)
                }
            }
        }

        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Enregistrer") {
                    let newPlant = Plant(
                        name: name,
                        imageName: globalLastPhotoTaken.isEmpty
                            ? nil : globalLastPhotoTaken,
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
        .navigationTitle("Nouvelle plante")
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
    }
}

#Preview {
    NavigationStack {
        AddPlantView(navPath: .constant(NavigationPath())) { plant in
            print("Preview: a plant named '\(plant.name)'")
        }
    }
}
