//
//  ImagePicker.swift
//  imageRecongition
//
//  Created by Vijayaganapathy Pavithraa on 16/7/24.
//

import SwiftUI
import CoreML

// ImagePicker

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var label: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // Not used in this case
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            self.parent.selectedImage = image
            self.parent.label = analyzeImage(image: image)
        }
        
        private func analyzeImage(image: UIImage) -> String {
            guard let buffer = image.resize(size: CGSize(width: 224, height: 224))?
                .getCVPixelBuffer() else {
                return ""
            }
            
            do {

                let config = MLModelConfiguration()
// ########## Here you should provide the name of your ML model ######
                let model = try YogaPoseClassfier(configuration: config)
                let input = YogaPoseClassfierInput(image: buffer)
// #################################################################
                let output = try model.prediction(input: input)
                let text = output.target
                return text
            }
            catch {
                print(error.localizedDescription)
                return ""
            }
        }
    }
}
