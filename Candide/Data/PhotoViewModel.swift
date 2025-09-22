import Foundation

class PhotoViewModel: ObservableObject, CameraManagerDelegate {
    @Published var photos: [String] = []
    let cameraManager = CameraManager()

    init() {
        cameraManager.delegate = self
    }

    func takePhoto() {
        cameraManager.capturePhoto()
    }

    // Delegate appelé par CameraManager
    func didCapturePhoto(named fileName: String) {
        DispatchQueue.main.async {
            self.photos.append(fileName)
        }
    }
}
