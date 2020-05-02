//
//  CardDetailView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/17/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI


//work on this later
struct CardDetailView: View {
    
    
    var body : some View{
        
        VStack{
            
            Text("This is the card detail view")
            Button(action: {
                print("something")
            }) {
                Text("hi")
            }
            }.background(Color.white)
            
            .padding(.top, -75)
            
        }
    }

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
    }
}


