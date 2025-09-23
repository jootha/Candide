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
            }
        }.onAppear {
            viewModel.cameraManager.startSession()
        }
        .onDisappear {
            viewModel.cameraManager.stopSession()
        }
    }
}
