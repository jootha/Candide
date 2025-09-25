//
//  EditPlantView.swift
//  Candide
//
//  Created by Flood on 18/09/2025.
//

import SwiftUI

struct EditPlantView: View {
    @ObservedObject var plant: Plant
    @FocusState private var isTextFieldFocused: Bool
    @State var tmpPlantName: String
    @State var tmpPlantSoil: SoilType
    @State var tmpPlantSunLight: Sunlight
    @State var tmpPlantWatering: WateringFrequency
    @State var tmpPlantIsDoor : Bool
    @State var tmpPlantImageName : String

    init(plant: Plant) {
        self.plant = plant
        _tmpPlantName = State(initialValue: plant.name)
        _tmpPlantSoil = State(initialValue: plant.soilType)
        _tmpPlantSunLight = State(initialValue: plant.sunlight)
        _tmpPlantWatering = State(initialValue: plant.watering)
        _tmpPlantIsDoor = State(initialValue: plant.isIndoor)
        _tmpPlantImageName = State(initialValue: plant.imageName!)
    }

    @State var selectedSoil: SoilType = .wellDrained
    @State var selectedSunLight: Sunlight = .fullSun
    @State var selectedWatering: WateringFrequency = .daily
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var photoViewModel = PhotoViewModel()
    @State private var showCamera = false
    @State private var selectedPhoto: UIImage? = nil
    @State private var showFullScreen = false
    
    var imageNew: Image {
        // Photo sauvegardée dans la plante (asset ou documents)
        if let imageName = plant.imageName {
            // Si c’est une photo prise avec la caméra (documents)
            let url = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            )[0]
                .appendingPathComponent(imageName)
            if FileManager.default.fileExists(atPath: url.path),
               let uiImage = UIImage(contentsOfFile: url.path)
            {
                return Image(uiImage: uiImage)
            } else {
                // Sinon c’est une image des Assets
                return Image(imageName)
            }
        }
        
        // Sinon, photo prise
        if !globalLastPhotoTaken.isEmpty {
            let url = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            )[0]
                .appendingPathComponent(globalLastPhotoTaken)
            if let uiImage = UIImage(contentsOfFile: url.path) {
                return Image(uiImage: uiImage)
            }
        }
        return Image("default")
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("**Nom**", text: $plant.name)
                //  IMAGES??t???
                Picker("Ensoleillement", selection: $selectedSunLight) {
                    ForEach(Sunlight.allCases, id: \.self) { light in
                        Text(light.rawValue)
                    }
                }
                Picker("Type de sol", selection: $selectedSoil) {
                    ForEach(SoilType.allCases, id: \.self) { soil in
                        Text(soil.rawValue)
                    }
                }
                Picker("Arrosage", selection: $selectedWatering) {
                    ForEach(WateringFrequency.allCases, id: \.self) { soil in
                        Text(soil.rawValue)
                    }
                }
                Toggle("En Interieur?", isOn: $plant.isIndoor)
                
                // Affichage des images avec gesture
                if let uiImage = photoViewModel.photo {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 350)
                        .clipped()
                        .cornerRadius(12)
                        .onTapGesture {
                            selectedPhoto = uiImage
                            showFullScreen = true
                        }
                } else if let imageName = plant.imageName {  //Image enregistré en cache
                    let url = FileManager.default.urls(
                        for: .documentDirectory,
                        in: .userDomainMask
                    )[0]
                        .appendingPathComponent(imageName)
                    
                    if let uiImage = UIImage(contentsOfFile: url.path) {
                        Image(uiImage: uiImage).resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 350)
                            .clipped()
                            .cornerRadius(12)
                            .onTapGesture {
                                selectedPhoto = UIImage(named: imageName)
                                showFullScreen = true
                            }
                    } else {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 350)
                            .clipped()
                            .cornerRadius(12)
                            .onTapGesture {
                                selectedPhoto = UIImage(named: imageName)
                                showFullScreen = true
                            }
                    }
                    
                } else {
                    Image("default")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350, height: 350)
                        .clipped()
                        .cornerRadius(12)
                        .onTapGesture {
                            selectedPhoto = UIImage(named: "default")
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
                    }.sheet(isPresented: $showCamera) {
                        CameraScreen(viewModel: photoViewModel)
                    }
                    Spacer()
                }
            }
            .scrollContentBackground(.hidden)
            .background(
                Color.cYellow.opacity(0.3),
                in: RoundedRectangle(cornerRadius: 12)
            )
            .onChange(of: photoViewModel.photo) { new in
                print(globalLastPhotoTaken)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        plant.name = tmpPlantName
                        plant.soilType = tmpPlantSoil
                        plant.imageName = tmpPlantImageName
                        plant.watering = tmpPlantWatering
                        plant.sunlight = tmpPlantSunLight
                        plant.isIndoor = tmpPlantIsDoor
                        plant.imageName = tmpPlantImageName
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        plant.soilType = selectedSoil
                        plant.imageName = globalLastPhotoTaken.isEmpty ? nil : globalLastPhotoTaken
                        plant.watering = selectedWatering
                        plant.sunlight = selectedSunLight
                        dismiss()
                    }
                    .disabled(
                        plant.name.trimmingCharacters(in: .whitespaces).isEmpty
                    )
                    .tint(.cGreen)
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
        }
    }
}

#Preview {
    EditPlantView(
        plant: plantListGlobalVar.plantList[0],
//        tmpPlantName: plantListGlobalVar.plantList[0].name
    )
}
