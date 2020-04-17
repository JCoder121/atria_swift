//
//  CardDetailView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/17/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

struct CardDetailView: View {
    var body : some View{
        
        VStack{
            
            Text("This is the card detail view")
            Button(action: {
                print("something happened")
            }) {
                Text("yo there")
            }
            }.background(Color.white)
            .clipShape(Rounded())
            .padding(.top, -75)
            
        }
    }

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
    }
}

struct Rounded : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
}
