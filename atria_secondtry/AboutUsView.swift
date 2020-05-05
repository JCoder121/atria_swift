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
            Spacer()
                .frame(height:25)
            
            Text("Meet the Devs").fontWeight(.heavy).font(.largeTitle)
            
            Spacer()
                .frame(height:60)
            HStack {
                
                Image("image-39")
                .resizable()
                .scaledToFit()
                //.alignmentGuide(.leading, computeValue: {_ in 30})
                .shadow(radius:10)
                .frame(width: 160.0, height: 160.0, alignment: .leading)
                Text("Jeffrey Chen")                    .font(.custom("Futura", size: 20))
                    .padding()
                Spacer()


            }
            .padding(25)

            HStack {
                Image("image-40")
                .resizable()
                .scaledToFit()
                //.alignmentGuide(.leading, computeValue: {_ in 30})
                .shadow(radius:10)
                .frame(width: 160.0, height: 160.0, alignment: .leading)
                Text("Stephanie Zhang")
                    .font(.custom("Futura", size: 20))
                    .padding()
                Spacer()

            }
            .padding(25)
            Spacer()
            
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
