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
   
    //filter when searching?
    //this can just be fetch request with a predicate but need to indicate a symbol/sort function
    
    func delete_card(at offsets: IndexSet) {
    for offset in offsets {
        let card = cards[offset]
        managedObjectContext.delete(card)
        }
        
        try? managedObjectContext.save()
    }
    
    func delete_all() {
        
        //if something goes bad this is failsafe to delete everything in tableview
        //doesn't refresh, let user manually delete
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
    
    var body: some View {
        
        //this view displays the past saved entries
        VStack{
            HStack {
               Text("Past Entries").fontWeight(.heavy).font(.largeTitle).padding()
               Spacer()
               
                
                Button(action: {
                   //better looking delete function later
                    self.delete_all()
                    //need to refresh the view, show nothing there anymore
                })
                {
                    Text("Clear").font(.title).padding()
                        .foregroundColor(Color.red)
                }
            
            }
            
            List {
                ForEach(cards, id: \.self) { card in
            
                Button(action: {
                    self.showCardDetail.toggle()
                   
                })
                {
                    //Image("Eosinophil")
                Image(uiImage: UIImage(data: card.picture ?? self.image)!)
                              .resizable()
                              .renderingMode(.original)
                              .aspectRatio(contentMode: .fit)
                         
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text("\(card.classification!)")
                            //Text("Classify")
                            .font(.custom("Futura", size: 25))
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        
                        Text("\(card.dateAdded!)")
                        //Text("01/01/20")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("\(card.name!)")
                            //Text("card name")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                
                .padding()
                    }
                .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius:10)
                            .stroke(Color(.sRGB, red:150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                        )
                            .padding([.top, .horizontal])
                    
                .sheet(isPresented: self.$showCardDetail){
                            CardDetailView()
                    //do card detail view later -> only for the name change
                            }
                    }.onDelete(perform: delete_card)
                
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

/*
 //this is for changing the naming stuff if it would be used
 
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
extension CardData {
    
    
    
    // to get an instance with specific name
    class func instance(with name: String) -> CardData? {
        let request = CardData.fetchRequest()

        // create an NSPredicate to get the instance you want to make change
        let predicate = NSPredicate(format: "name = %@", name)
        request.predicate = predicate

        do {
            let names = try context.fetch(request)
            return names.first as! CardData
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    // to update an instance with specific name
    func updateName(with name: String) {
        self.name = name
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    // to delete an instance
    func delete() {
        context.delete(self)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}

/*
func howItWorks() {
   guard let name = CardData.instance(with: "a task's name") else { return }
   task.updateName(with: "the new name")
   task.delete()
}
*/
*/
