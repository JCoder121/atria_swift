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
    
    var body: some View {
       
        //display the past saved entries
        //all data - should be one scroll view always calling functions
        VStack{
            
            HStack {
               Text("Past Entries").fontWeight(.heavy).font(.largeTitle).padding()
               Spacer()
               
                Button(action: {
                    print("edit button pressed")
                    //delete cards process later
                })
                {
                    Text("Edit").font(.title).padding()
                        .foregroundColor(Color.red)
                }
                
                       
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20){
                    VStack(alignment: .leading, spacing: 12){
                       

                        Button(action: {
                            self.show.toggle()
                        }) {
                            VStack(alignment: .leading){
                            Image("Eosinophil").renderingMode(.original)
                                //.padding()
                                //.border(Color.purple)
                            VStack(alignment: .leading, spacing: 6){
                                Text("My Classification 1").fontWeight(.heavy).foregroundColor(.black)
                                Text("Eosinophil (98%)").foregroundColor(.black)
                                Text("01/01/2000").foregroundColor(.gray)
                                        
                                
                                }
                            }
                            
                                
                        }
                        //DATA ENTRIES
                        //there shoulud be option to make entry name
                        
                    
                        
                        }.padding()
                        .border(Color.purple, width: 4)
                        .cornerRadius(25)
                        //will debate on corner radius later
                    
                        .sheet(isPresented: $show){
                            CardDetailView()
                            }
    
                    }
                }
                //will make list to go in here later, return data and stuff
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
