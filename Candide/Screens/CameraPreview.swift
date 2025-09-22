import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    var layer: AVCaptureVideoPreviewLayer?

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        if let layer = layer {
            layer.frame = UIScreen.main.bounds
            view.layer.addSublayer(layer)
            print("=== Dans mon layer")
            print(view.layer)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        print("updateuiview : " + (layerLocalVar?.videoGravity.rawValue)!)
        
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
        }
    }
}
