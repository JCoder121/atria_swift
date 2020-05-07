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
    
    @State var showSplash: Bool = true
    //@State var showCards: Bool = false
    @State var showCards: Bool = true
    
    var body: some View {
            

        ZStack {
            if (showCards) {
            TabView {
                //takes care of scrolling card view
                CardView()
                    .tabItem {
                Image(systemName: "house")
                        Text("Home")
                        
                }
                //takes care of scanning in pictures for input
                NewPictureView()
                    .tabItem {
                        Image(systemName: "camera")
                        Text("Add")
                }
                
                //picture of the peoples
                AboutUsView()
                    .tabItem {
                        Image(systemName: "info.circle")
                        Text("About Us")
                }
            }
            }
            
            
            SplashScreen2()
              .opacity(showSplash ? 1 : 0)
              .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                  withAnimation() {
                      self.showSplash = false
                    self.showCards = true
                  }
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
