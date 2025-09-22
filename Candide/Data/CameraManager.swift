import AVFoundation
import UIKit

protocol CameraManagerDelegate: AnyObject {
    func didCapturePhoto(_ image: UIImage)
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
        print("Session running: \(session.isRunning)")

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
        if let data = photo.fileDataRepresentation(),
           let image = UIImage(data: data) {
            delegate?.didCapturePhoto(image)
        }
    }
}
