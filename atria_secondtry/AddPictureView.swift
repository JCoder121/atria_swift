//
//  ScanView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/16/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI


struct AddPictureView: View {
    
    @State var show: Bool = false
    @State var show_analyze: Bool = false
    
    @State var showImagePicker: Bool = false
    @State var uiImage: UIImage? = nil
    
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("Add Picture").fontWeight(.heavy).font(.largeTitle).padding()
            
            Spacer()
            
            if (uiImage == nil) {
                Image(systemName: "camera")
                //change this to something like a gray rectangle later
                
                
            } else {
                Image(uiImage: uiImage!)
                    .resizable()
                    .frame(width: 320, height: 240)
                    .cornerRadius(10)
                
            }
            
            Spacer()
            
            Button(action: {
                //machine learning here
                if(self.uiImage==nil) {
                    print("nothing to analyze")
                }
                else {
                    print("something to analyze")
                }})
            {
                Text("ANALYZE")
                    //.fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: 275)
                    .padding()
                    //.font(.title)
                    .font(.custom("Futura", size: 20))
                    .background(Color(red: 219 / 255, green: 184 / 255, blue: 233 / 255))
                    .cornerRadius(30)
                    //.padding(.horizontal, 20)
                    .foregroundColor(.white)
                
            }
            
            HStack(spacing: 3) {
                
                Button(action: {
                    print("will toggle camera")
                })
                {
                    Text("Use Camera")
                        .font(.custom("Futura", size: 20))
                        //.fontWeight(.bold)
                        //.font(.title)
                        .padding()
                        .background(Color(red: 219 / 255, green: 184 / 255, blue: 233 / 255))
                        .cornerRadius(30)
                    //(LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .padding(25)
                }
                
                
                Button(action: {
                    self.showImagePicker.toggle()
                })
                {
                    Text("Photo Library")
                        //.fontWeight(.bold)
                        //.font(.title)
                        .padding()
                        .background(Color(red: 219 / 255, green: 184 / 255, blue: 233 / 255))
                        .cornerRadius(30)
                        .font(.custom("Futura", size: 20))
                    //(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.red]), startPoint: .leading, endPoint: .trailing))
                        //.cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(10)
                }
                .padding()
                    
                    
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    self.showImagePicker = false
                    
                    
                }, content: {
                    ImagePicker(isShown: self.$showImagePicker, uiImage: self.$uiImage)
                })
                
            }
            
            Spacer()
            
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var uiImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var isShown: Bool
        @Binding var uiImage: UIImage?
        
        init(isShown: Binding<Bool>, uiImage: Binding<UIImage?>) {
            _isShown = isShown
            _uiImage = uiImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            uiImage = imagePicked
            isShown = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, uiImage: $uiImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}

struct AddPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AddPictureView()
    }
}
