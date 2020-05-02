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
    @State var change_name = ""
    
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
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CardData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
       
        do {
            try persistentContainer.viewContext.executeAndMergeChanges(using: deleteRequest)
           
        } catch {
            print ("There was an error")
        }
        
    
    }

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    private func alert() {
           
           let alert = UIAlertController(title: "Change Name", message: "test", preferredStyle: .alert)
           
           alert.addTextField() { textField in
               textField.placeholder = "Enter your name"
           }
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
           showAlert(alert: alert)
           
           alert.addAction(UIAlertAction(title: "Done", style: .default) { _ in
               let textField = alert.textFields![0] as UITextField
               self.change_name = textField.text ?? "Name"
               
            //return self.change_name
           })
       }

       func showAlert(alert: UIAlertController) {
           if let controller = topMostViewController() {
               controller.present(alert, animated: true)
           }
       }

       private func keyWindow() -> UIWindow? {
           return UIApplication.shared.connectedScenes
           .filter {$0.activationState == .foregroundActive}
           .compactMap {$0 as? UIWindowScene}
           .first?.windows.filter {$0.isKeyWindow}.first
       }

       private func topMostViewController() -> UIViewController? {
           guard let rootController = keyWindow()?.rootViewController else {
               return nil
           }
           return topMostViewController(for: rootController)
       }

       private func topMostViewController(for controller: UIViewController) -> UIViewController {
           if let presentedController = controller.presentedViewController {
               return topMostViewController(for: presentedController)
           } else if let navigationController = controller as? UINavigationController {
               guard let topController = navigationController.topViewController else {
                   return navigationController
               }
               return topMostViewController(for: topController)
           } else if let tabController = controller as? UITabBarController {
               guard let topController = tabController.selectedViewController else {
                   return tabController
               }
               return topMostViewController(for: topController)
           }
           return controller
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
                    Text("Clear All").font(.headline).padding()
                        .foregroundColor(Color.red)
                }
            
            }
            
            List {
                ForEach(cards, id: \.self) { card in
            
                Button(action: {
                    self.showCardDetail.toggle()
                  
                        //self.alert()
                    //name changing
                    
                    
                  
                   
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
                        //    Text("card name")
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
                /*
                .sheet(isPresented: self.$showCardDetail){
                            CardDetailView()
                    //do card detail view later -> only for the name change
                            }
                     */
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

extension NSManagedObjectContext {
    /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
    ///
    /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
    /// - Throws: An error if anything went wrong executing the batch deletion.
    public func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
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
