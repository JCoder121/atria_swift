//
//  NewPictureView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/19/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI
import CoreData
import Vision
import CoreML


struct NewPictureView: View {
      
    @FetchRequest(entity: CardData.entity(),sortDescriptors: []) var cards: FetchedResults<CardData>
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var image: Data = .init(count:0)
    
    @State var showImagePicker: Bool = false
    @State var showCameraImagePicker: Bool = false
    @State var showAnalysis: Bool = false
    @State var showFinish: Bool = false
    
    
    @State var classificationLabel: String = ""
    @State var topClassification: String = ""
    @State var cellName: String = "WBC Classification"
    

    
    ///ML MODEL
    /// - Tag: PerformRequests
    func updateClassifications(for image: UIImage) {
        
        guard let model = try? VNCoreMLModel(for: CellClassification().model) else {
            return
        }
        
        let request = VNCoreMLRequest(model: model, completionHandler: { request, error in
            self.processClassifications(for: request, error: error)
        })
        request.imageCropAndScaleOption = .scaleFill
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([request])
               
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
         
    }
    
    
    /// Updates the UI with the results of the classification.
    /// - Tag: ProcessClassifications
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            
            guard let results = request.results else {
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
            let classifications = results as! [VNClassificationObservation]
        
            if classifications.isEmpty {
                print("empty")
            } else {
                // Display top classifications ranked by confidence in the UI.
                let topClassifications = classifications.prefix(1)
                
                _ = topClassifications.map { classification -> String in
                    
                    //gives the real output
                    self.topClassification = String(format: "%@", classification.identifier)
                return String(format: "%@", classification.identifier)
                    
                }
                
                self.classificationLabel =  self.topClassification
                
                //date added - always current date mm/dd/yyyy
                let today = Date()
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .short
                let toSave = formatter1.string(from: today)
                
                
                //Save into CoreData and reflect in home page
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let send = CardData(context: self.managedObjectContext)
                send.classification = self.classificationLabel
                send.picture = self.image
                send.name = self.cellName
                send.dateAdded = toSave
                
                
                do{
                    try context.save()
                } catch{
                   print(error)
                }
                
            }
        
        }
    }
    
   
    ///VIEW HANDLING
    var body: some View {

        VStack(alignment: .center, spacing: 30) {
           
            if !self.showFinish {
                Text("Add Picture").fontWeight(.heavy).font(.largeTitle).padding()
                if self.image.count != 0 && self.showFinish {
                   
                }
                
                if self.image.count != 0 {
                    
                    Spacer()
                   Image(uiImage: UIImage(data: self.image)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 320, height: 240)
                    
                    
                }
                    
                
                else{
                    Spacer()
                   Image(systemName: "photo.fill")
                }
               Spacer()
                
            //hide/show buttons with animations?
           
            if self.image.count != 0 {
            VStack{
            TextField("Name your classification?", text: $cellName)
                .frame(minWidth: 0, maxWidth: 240)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 2)
            }
            }
            
            if self.image.count != 0 {
           Button(action: {
            
            //Call ML, change views to finished classifying
            self.showFinish.toggle()
            self.updateClassifications(for: UIImage(data: self.image)!)
           })
           {
            Text("Analyze")
                    .frame(minWidth: 0, maxWidth: 275)
                    .padding()
                    .font(.custom("Futura", size: 20))
                    .background(Color(red: 219 / 255, green: 184 / 255, blue: 233 / 255))
                    .cornerRadius(30)
                    .foregroundColor(.white)
           }
            //analyze button is disabled if no image entered
            
           .disabled(self.image.count == 0)
               
                
         
            }
           
            
           HStack{
            
               Button(action: {
                self.showCameraImagePicker.toggle()
                    
               })
               {
                   Text("Use Camera")
                    .font(.custom("Futura", size: 20))
                    .padding()
                    .background(Color(red: 219 / 255, green: 184 / 255, blue: 233 / 255))
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .padding(10)
                    
               }.sheet(isPresented: self.$showCameraImagePicker, onDismiss: {
                self.showCameraImagePicker = false
               }, content: {
                //most likely crashes on simulator
                CameraImage(showCameraImagePicker: self.$showCameraImagePicker, image: self.$image)
               })
            
            
            
               
               Button(action: {
                    self.showImagePicker.toggle()
                })
                {
                    Text("Photo Library")
                       
                       .font(.custom("Futura", size: 20))
                       .padding()
                       .background(Color(red: 219 / 255, green: 184 / 255, blue: 233 / 255))
                       .cornerRadius(30)
                       .foregroundColor(.white)
                       .padding(10)
               }

               .sheet(isPresented: self.$showImagePicker, onDismiss: {
                   self.showImagePicker = false
                   
                   
               }, content: {
                   ImagePicker(showImagePicker: self.$showImagePicker, image: self.$image)
               })
               
           }
           
           Spacer()
            }
            else {
                
                 FinishView()
                
                //self.showFinish.toggle()
               
                
            }
       }
   }
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}





struct FinishView: View {
    @State var showFirstStroke: Bool = false
    @State var showSecondStroke: Bool = false
    @State var showCheckMark: Bool = false
    
    let screenWidth = UIScreen.screenWidth
    let screenHeight = UIScreen.screenHeight
    
    var body: some View {
        ZStack {
        Circle()
            .strokeBorder(lineWidth: showFirstStroke ? 2 : 50, antialiased: false)
            .frame(width: 100, height: 100)
            .foregroundColor(showFirstStroke ? .green: .pink)
            .rotation3DEffect(.degrees(showFirstStroke ? 0 : 360), axis: (x: 1, y: 1, z: 1))
            .animation(Animation.easeInOut(duration: 2).delay(1))
            .onAppear() {
                self.showFirstStroke.toggle()
        }
        
        
        Circle()
            .strokeBorder(lineWidth: showSecondStroke ? 2 : 50, antialiased: false)
            .frame(width: 100, height: 100)
            .foregroundColor(showSecondStroke ? .green: .pink)
            .rotation3DEffect(.degrees(showSecondStroke ? 0 : 360), axis: (x: 1, y: 1, z: 1))
            .animation(Animation.easeInOut(duration: 2).delay(1))
            .onAppear() {
                self.showSecondStroke.toggle()
        }
            
            
            Path { path in
                path.move(to: CGPoint(x: 25, y: 45))
                path.addLine(to: CGPoint(x: 25, y: 45))
                path.addLine(to: CGPoint(x: 40, y: 60))
                path.addLine(to: CGPoint(x: 70, y: 30))
                
            }.trim(from: 0, to: showCheckMark ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .foregroundColor(.green).offset(x: screenWidth/2.6, y: screenHeight/2.6)
                .animation(Animation.easeInOut.delay(3))
                .onAppear() {
                    self.showCheckMark.toggle()
            }
        
            Text("Classification Added")
                .font(.custom("Futura", size: 30))
                .offset(x: 0, y: screenWidth/4)
            
        }
    }
}


struct NewPictureView_Previews: PreviewProvider {
    static var previews: some View {
        NewPictureView()
    }
}

