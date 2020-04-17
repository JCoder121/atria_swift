//
//  CardView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/16/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @State var show: Bool = false
    
    var image: String
    var date: String
    var cellType: String
    var author: String
    var body: some View {
        
        //display the past saved entries
        //all data - should be one scroll view always calling functions
        VStack{
            
            HStack {
                Text("Past Entries").fontWeight(.heavy).font(.largeTitle).padding()
                Spacer()
                //toggle this button later
                Text("Edit").font(.title).padding()
                
            }
            ScrollView {
            VStack {
                Image("Eosinophil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("4/16/20")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Eosinophil")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text("Stephanie Zhang")
                            .font(.caption)
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
            
        }
        
    }
    }
    struct CardView_Previews: PreviewProvider {
        static var previews: some View {
            CardView(image: "Eosinophil", date: "4/15/20", cellType: "Eosinophil", author: "Stephanie Zhang")
        }
    }
}
