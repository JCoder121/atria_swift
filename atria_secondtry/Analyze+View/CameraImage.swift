//
//  CameraImage.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/23/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct CameraImage: UIViewControllerRepresentable {
    
    
    @Binding var showCameraImagePicker: Bool
    @Binding var image: Data
    
    
    func makeCoordinator() -> CameraImage.Coordinator {
        return CameraImage.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraImage>) -> UIImagePickerController{
        let picker = UIImagePickerController()
        
        
        picker.sourceType = .camera
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraImage>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var child: CameraImage
        
        init(child1: CameraImage) {
            child = child1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.showCameraImagePicker.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.child.image = data!
            self.child.showCameraImagePicker.toggle()
        }
        
    }
}

