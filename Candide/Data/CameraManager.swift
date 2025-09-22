import AVFoundation
import UIKit

protocol CameraManagerDelegate: AnyObject {
    func didCapturePhoto(named fileName: String)
}

class CameraManager: NSObject, ObservableObject {
    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    @Published var previewLayer: AVCaptureVideoPreviewLayer?

    weak var delegate: CameraManagerDelegate?

    override init() {
        super.init()
        setupSession()
    }

    private func setupSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo

        // Choisir la caméra arrière
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .back) else { return }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }

        if session.canAddInput(input) { session.addInput(input) }
        if session.canAddOutput(output) { session.addOutput(output) }

        session.commitConfiguration()

        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = .resizeAspectFill
        previewLayer = layer

        session.startRunning()
    }

    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard error == nil else { return }

        if let data = photo.fileDataRepresentation() {
            // Sauvegarder l’image dans Documents
            let fileName = "photo_\(UUID().uuidString.prefix(6)).jpg"
            let url = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask)[0].appendingPathComponent(fileName)
            try? data.write(to: url)

            // Notifier le delegate
            delegate?.didCapturePhoto(named: fileName)
        }
    }
}
