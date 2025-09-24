import SwiftUI
/*
 Lien entre le moteur caméra et l'appli SwiftUI.
 gère les données (les photos prises) et orchestré la communication entre SwiftUI <-> CameraManager
 */
class PhotoViewModel: ObservableObject, CameraManagerDelegate {
    
    //liste observable de toutes les photos prises. Quand elle change, SwiftUI met à jour l’écran automatiquement
    @Published var photo: UIImage = UIImage()
    
    
    //on instancie le moteur.
    let cameraManager = CameraManager()

    init() {
        //“quand la caméra capture une photo, appelle-moi” (on devient son delegate).
        cameraManager.delegate = self
    }
    
    //déclencher une capture.
    func takePhoto() {
        cameraManager.capturePhoto()
    }

    // callback du delegate → on ajoute la photo à la liste photos.

    func didCapturePhoto(_ image: UIImage) {
        let fileName = "plant_\(UUID().uuidString).jpg"
        if let savedName = saveImageToDocuments(image, fileName: fileName) {
            DispatchQueue.main.async {
                self.photo = image
                globalLastPhotoTaken = savedName
                print(globalLastPhotoTaken.description)
            }
        }
    }

    
    //sauvegardes dans le FileManager
    func saveImageToDocuments(_ image: UIImage, fileName: String) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
        do {
            try data.write(to: url)
            return fileName
        } catch {
            print("Erreur sauvegarde : \(error)")
            return nil
        }
    }

}
