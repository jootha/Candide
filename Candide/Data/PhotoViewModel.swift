import SwiftUI

class PhotoViewModel: ObservableObject, CameraManagerDelegate {
    @Published var photos: [UIImage] = []
    let cameraManager = CameraManager()

    init() {
        cameraManager.delegate = self
    }

    func takePhoto() {
        cameraManager.capturePhoto()
    }

    // Delegate appelé quand CameraManager capture une photo
    func didCapturePhoto(_ image: UIImage) {
        DispatchQueue.main.async {
            self.photos.append(image)
        }
    }
}
