//
//  ContentView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/15/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//get button images later
//

import SwiftUI

struct HomePage: View {
    

    var body: some View {
        VStack {
            
            
            TabView {
                //takes care of scrolling card view
                CardView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                        //other materials here
                        //show cards here
                        
                }
                //takes care of scanning in pictures for input
                AddPictureView()
                    .tabItem {
                        Image(systemName: "camera")
                        Text("Add")
                        //do things
                }
                
                //filler view for now, could be of use later
                AboutUsView()
                    .tabItem {
                        Image(systemName: "info.circle")
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
