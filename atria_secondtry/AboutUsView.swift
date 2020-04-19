//
//  ThirdView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/16/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI



struct ListItem: Identifiable {
    var id = UUID()
    
    var item: String
}

struct AboutUsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: CardData.getAllEntries()) var entries: FetchedResults<CardData>
    @State private var newEntry = ""
 
    
    init() {
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    let my_list: [ListItem] = [
        ListItem(item: "yes"),
        ListItem(item: "another one")
        ]
      
    @State var show: Bool = false
 
    var body: some View {
        VStack {
            Text("Meet the Devs").fontWeight(.heavy).font(.largeTitle).padding()
            Text("Pictures go here or smth").font(.title).padding()
            
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
