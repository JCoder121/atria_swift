//
//  ContentView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/15/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//get button images later
//

import SwiftUI

//hi jeff meow meow
//hi jeff meow meow meow

struct HomePage: View {
    

    var body: some View {
        VStack {
            
            
            TabView {
                //takes care of scrolling card view
                CardView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Home")
                        //other materials here
                        //show cards here
                        
                }
                //takes care of scanning in pictures for input
                AddPictureView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Add")
                        //do things
                }
                
                //filler view for now, could be of use later
                AboutUsView()
                    .tabItem {
                        Image(systemName: "mappin.circle.fill")
                        Text("About Us")
                }
            }
    
        }
            
    }
 
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
