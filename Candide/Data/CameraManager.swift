import AVFoundation
import UIKit

protocol CameraManagerDelegate: AnyObject {
    func didCapturePhoto(_ image: UIImage)
}

class CameraManager: NSObject, ObservableObject {
    //Central : Reçoit les données de la caméra et les envoie à différents “outputs” (par ex. un fichier, un écran)
    private let session = AVCaptureSession()
    //c’est un type de sortie, permet de prendre une photo.
    private let output = AVCapturePhotoOutput()
    //couche graphique (CALayer), montre en direct ce que voit la caméra.
    @Published var previewLayer: AVCaptureVideoPreviewLayer?
    //Je sais capturer des photos, mais je ne sais pas quoi en faire… donc je vais prévenir quelqu’un d’autre quand j’en ai une
    //Eviter fuites mémoire : je garde une référence, mais je n’empêche pas l’autre objet d’être détruit quand il n’est plus utilisé”
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
    }

    func capturePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    func stopSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }

}

//récupères les données binaires de la photo et les convertis en UIImage.
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
