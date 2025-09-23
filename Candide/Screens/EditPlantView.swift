//
//  EditPlantView.swift
//  Candide
//
//  Created by Flood on 18/09/2025.
//

import SwiftUI

struct EditPlantView: View {
    @ObservedObject var plant: Plant
    @State var tmpPlantName: String = plantListGlobalVar.plantList[0].name
    @State var selectedSoil: SoilType = .wellDrained
    @State var selectedSunLight: Sunlight = .fullSun
    @State var selectedWatering: WateringFrequency = .daily
    @Environment(\.dismiss) var dismiss
    
    
    @ObservedObject var photoViewModel = PhotoViewModel()
    @State private var showCamera = false
    @State private var selectedPhoto: UIImage? = nil
    @State private var showFullScreen = false
    
    var imageNew: Image {//if else empty && ou
        if !globalLastPhotoTaken.isEmpty {
            let url = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
                .appendingPathComponent(globalLastPhotoTaken)
            
            if let uiImage = UIImage(contentsOfFile: url.path) {
                return Image(uiImage: uiImage)
                    
            } else {//Image des Assets
                if let image = plant.imageName {
                    
                    return Image(image)
                        
                }
            }
        }
        return Image("default")
                
        
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("**Nom**", text: $plant.name)
                //  IMAGES??t???
                Picker("Ensoleillement", selection: $plant.sunlight) {
                    ForEach(Sunlight.allCases, id: \.self) { light in
                        Text(light.rawValue)
                    }
                }
                Picker("Type de sol", selection: $plant.soilType) {
                    ForEach(SoilType.allCases, id: \.self) { soil in
                        Text(soil.rawValue)
                    }
                }
                Picker("Arrosage", selection: $plant.watering) {
                    ForEach(WateringFrequency.allCases, id: \.self) { soil in
                        Text(soil.rawValue)
                    }
                }
                Toggle("En Interieur?", isOn: $plant.isIndoor)
                
                imageNew
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 350)
                    .clipped()
                    .cornerRadius(12)
                    .onTapGesture {
                        //photoViewModel.photo = uiImage
                        selectedPhoto = photoViewModel.photo
                        showFullScreen = true
                }

                if selectedPhoto != nil {
                   Image(uiImage: selectedPhoto!)
                      .resizable()
                      .scaledToFill()
                        .frame(width: 1, height: 1)
               }
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
            }
            .onChange(of: photoViewModel.photo){ new in
                print(globalLastPhotoTaken)
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
            //Edit Image
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        plant.name = tmpPlantName
                        globalLastPhotoTaken = ""
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        plant.soilType = selectedSoil
                        plant.imageName = globalLastPhotoTaken.isEmpty ? nil : globalLastPhotoTaken
                        plant.watering = selectedWatering
                        plant.sunlight = selectedSunLight
                        globalLastPhotoTaken = ""
                        dismiss()
                    }
                    .disabled(plant.name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {EditPlantView(plant: plantListGlobalVar.plantList[0])}
