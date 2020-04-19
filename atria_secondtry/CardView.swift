//
//  CardView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/16/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI
import CoreData

struct CardView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: CardData.entity(),sortDescriptors: [NSSortDescriptor(keyPath: \CardData.name, ascending: true)]) var cards: FetchedResults<CardData>
    
   
    @State var showCardDetail: Bool = false
    @State var image: Data = .init(count: 0)
   
    
    func delete_all() {
        
        //if something goes bad this is failsafe to delete everything in tableview
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CardData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            
        } catch {
            print ("There was an error")
        }
    
    }

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    //need to refresh body immediately after deleting


    var body: some View {
        
        //this view displays the past saved entries
        
        VStack{
            HStack {
               Text("Past Entries").fontWeight(.heavy).font(.largeTitle).padding()
               Spacer()
               
                Button(action: {
                   //better looking delete function later
                    self.delete_all()
                    
                })
                {
                    Text("Delete").font(.title).padding()
                        .foregroundColor(Color.red)
                }
                       
            }
            
            //List(cards, id: \.self) { card in
            List(cards) { card in
                Button(action: {
                    self.showCardDetail.toggle()
                }){
                //Image("Eosinophil")
               Image(uiImage: UIImage(data: card.picture ?? self.image)!)
                              .resizable()
                              .renderingMode(.original)
                              .aspectRatio(contentMode: .fit)
                         
        
                HStack {
                    VStack(alignment: .leading) {
                       
                        
                        Text("4/16/20")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                       Text("Eosinophil")
                       //Text("\(card.name!)")
                        //Text(card.name)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)

                        Text("Card Entry name")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                    }.cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius:10)
                                .stroke(Color(.sRGB, red:150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                        )
                            .padding([.top, .horizontal])
                    
                .sheet(isPresented: self.$showCardDetail){
                            CardDetailView()
                            }
                
                }
              
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
