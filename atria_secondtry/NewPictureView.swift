//
//  NewPictureView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/19/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI
import CoreData

struct NewPictureView: View {
      
    @FetchRequest(entity: CardData.entity(),sortDescriptors: []) var cards: FetchedResults<CardData>
    @Environment(\.managedObjectContext) var managedObjectContext

    //@State var image_to_save: Image
    @State var image: Data = .init(count:0)
    @State var showImagePicker: Bool = false
    @State var showAnalysis: Bool = false
    
    
    let model = Classification()
    @State var output_classification: String = ""
    
    
    //alert or some other view to name the thing
    @State var userLabel: String = ""
    
    ///ML MODEL
    //test

    ///VIEW HANDLING
    var body: some View {

        VStack(alignment: .center, spacing: 30) {
           
            Text("Add Picture").fontWeight(.heavy).font(.largeTitle).padding()
            if self.image.count != 0 {
                //image_to_save = Image(uiImage: UIImage(data: self.image)!)
               Image(uiImage: UIImage(data: self.image)!)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            else{
               Image(systemName: "photo.fill")
            }
           Spacer()
           
           Button(action: {
            //need to make sure you can only press analzye after choosing image
              //FIX machine learning here
            //if self.image.count != 0 {
           /*
            guard (try? self.model.prediction(image: Image(uiImage: UIImage(data: self.image)!) as! CVPixelBuffer)) != nil else{
                fatalError("Unexpected runtime error.")
            }
            */
            //let output_classification = model.
                
                //self.showAnalysis.toggle()
            
            
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let send = CardData(context: self.managedObjectContext)
                send.name = self.userLabel
                send.picture = self.image
                
                //title stuff here
        
            
                do{
                    try context.save()
                } catch{
                   print(error)
               }
                
            //}
            
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
           
           HStack{
               
               Button(action: {
                   print("will toggle camera")
               })
               {
                   Text("Use Camera")
                    .font(.custom("Futura", size: 20))
                    .padding()
                    .background(Color(red: 219 / 255, green: 184 / 255, blue: 233 / 255))
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .padding(10)
                    
               }

               
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
   }
}



struct NewPictureView_Previews: PreviewProvider {
    static var previews: some View {
        NewPictureView()
    }
}
