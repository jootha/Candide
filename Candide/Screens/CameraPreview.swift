import AVFoundation
import SwiftUI

//Pont entre UIKit (preview caméra) et SwiftUI.
struct CameraPreview: UIViewRepresentable {//permet d’insérer une vue UIKit
    var layer: AVCaptureVideoPreviewLayer?

    //crée un UIView vide et y ajoute la couche de preview.
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        if let layer = layer {
            layer.frame = UIScreen.main.bounds
            view.layer.addSublayer(layer)
        }
        return view
    }

    //ajuste la taille de la couche si l’écran change.
    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = layer {
            DispatchQueue.main.async {
                layer.frame = uiView.bounds
            }
        }
    }
}

struct CameraScreen: View {
    //observes le PhotoViewModel
    @ObservedObject var viewModel: PhotoViewModel
    //Fermer la modal
    @Environment(\.dismiss) private var dismiss

    

    var body: some View {
        ZStack {
            if let layer = viewModel.cameraManager.previewLayer {
                CameraPreview(layer: layer)
                    .ignoresSafeArea()
            } else {
                Color.cPink.ignoresSafeArea()
            }

            VStack {
                Spacer()
                
                //Bouton prendre une photo
                Button(action: {
                    viewModel.takePhoto()
                    dismiss()   //ferme la modal
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 70, height: 70)
                        .padding()
                        .shadow(radius: 5)
                }

                // Liste des photos capturées
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.photos.indices, id: \.self) { index in
                            Image(uiImage: viewModel.photos[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                }
                .background(Color.black.opacity(0.3))
            }
        }.onAppear {
            viewModel.cameraManager.startSession()
        }
        .onDisappear {
            viewModel.cameraManager.stopSession()
        }
    }
}
