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

       @State var image: Data = .init(count:0)
       @State var show: Bool = false
       
       var body: some View {

           VStack(spacing: 30) {
               
                Text("Add Picture").fontWeight(.heavy).font(.largeTitle).padding()
                if self.image.count != 0 {
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
                  //machine learning here
                //if self.image.count != 0 {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                
                    let send = CardData(context: self.managedObjectContext)
                    send.name = "testingagain"
                    send.picture = self.image
                    
                    do{
                        try context.save()
                    } catch{
                       print(error)
                   }
                    
                //}
                
               })
                    
                   {
                      Text("Analyze")
                          .fontWeight(.bold)
                          .font(.title)
                          .padding()
                          .background(Color.red)
                          .cornerRadius(40)
                          .foregroundColor(.white)
                    }
               
              
               HStack{
                   
                   Button(action: {
                       print("will toggle camera")
                   })
                   {
                       Text("Use Camera")
                       .fontWeight(.bold)
                       
                       .padding()
                       .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .leading, endPoint: .trailing))
                       .cornerRadius(40)
                       .foregroundColor(.white)
                       .padding(10)
                   }
    
                   
                   Button(action: {
                        self.show.toggle()
                    })
                    {
                        Text("Photo Library")
                           .fontWeight(.bold)
                           
                           .padding()
                           .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.red]), startPoint: .leading, endPoint: .trailing))
                           .cornerRadius(40)
                           .foregroundColor(.white)
                           .padding(10)
                   }
                   .padding()
                   

                   .sheet(isPresented: self.$show, onDismiss: {
                       self.show = false
                       
                       
                   }, content: {
                       ImagePicker(show: self.$show, image: self.$image)
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
