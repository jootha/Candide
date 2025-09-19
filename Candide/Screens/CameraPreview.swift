import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    var layer: AVCaptureVideoPreviewLayer?

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        if let layer = layer {
            layer.frame = UIScreen.main.bounds
            view.layer.addSublayer(layer)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = layer {
            layer.frame = uiView.bounds
        }
    }
}

struct CameraScreen: View {
    @StateObject var viewModel = PhotoViewModel()

    var body: some View {
        ZStack {
            if let layer = viewModel.cameraManager.previewLayer {
                CameraPreview(layer: layer)
                    .ignoresSafeArea()
            } else {
                Color.black.ignoresSafeArea()
            }

            VStack {
                Spacer()

                Button(action: {
                    viewModel.takePhoto()
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 70, height: 70)
                        .padding()
                        .shadow(radius: 5)
                }

                // Liste des photos capturées
                List(viewModel.photos, id: \.self) { name in
                    Text(name)
                }
                .frame(height: 200)
            }
        }
    }
}
