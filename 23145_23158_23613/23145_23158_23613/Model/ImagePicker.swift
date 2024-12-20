import SwiftUI
import UIKit

// Struct para exibir um pegador de imagens vinculado ao aplicativo FOTOS do celular / ipad
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isImagePickerPresented: Bool
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedImage: UIImage?
        @Binding var isImagePickerPresented: Bool
        
        init(selectedImage: Binding<UIImage?>, isImagePickerPresented: Binding<Bool>) {
            _selectedImage = selectedImage
            _isImagePickerPresented = isImagePickerPresented
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
            }
            isImagePickerPresented = false
        }

        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isImagePickerPresented = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .savedPhotosAlbum 
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
