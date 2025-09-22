import SwiftUI
/*
 Lien entre le moteur caméra et l'appli SwiftUI.
 gère les données (les photos prises) et orchestré la communication entre SwiftUI <-> CameraManager
 */
class PhotoViewModel: ObservableObject, CameraManagerDelegate {
    
    //liste observable de toutes les photos prises. Quand elle change, SwiftUI met à jour l’écran automatiquement
    @Published var photos: [UIImage] = []
    
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
        DispatchQueue.main.async {
            self.photos.append(image)
        }
    }
}
