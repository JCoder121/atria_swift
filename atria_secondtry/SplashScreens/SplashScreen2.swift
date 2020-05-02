//
//  Indicator.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/21/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

//atria logo drawing
struct SplashScreen2: View {
    
    @State var animateTrimPath = false
    @State var rotateInfinity = false
    
    let my_scale = UIScreen.screenHeight/20
    let x_offset = UIScreen.screenWidth/3
    let y_offset = -UIScreen.screenHeight/3

    var body: some View {
        
        //scaling issues to resize based on simulator size?
        
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            Text("A T R I A")
            .foregroundColor(Color.black)
                .font(.custom("Futura", size: UIScreen.screenWidth/10))
                .offset(x: 0, y: UIScreen.screenHeight/7)
            
            //top arc
            ZStack {
                Path { path in
                    path.addLines([
                        .init(x: 14, y: 9),
                        .init(x: 10, y: 2),
                        .init(x: 9, y: 1.5),
                        .init(x: 8, y: 1),
                        .init(x: 7, y: 1.5),
                        .init(x: 6, y: 2),
                        .init(x: 2, y: 9)
                        
                    ])
                }
                .scale(my_scale, anchor: .topLeading)
                .stroke(Color.red, lineWidth: 20)
                .offset(x: -x_offset, y: y_offset)
                .onAppear() {
                    self.animateTrimPath.toggle()
                }
            }
            .scaleEffect(0.3, anchor: .center)

            //middle heartbeat
            ZStack {
                
                Path { path in
                    path.addLines([
                        .init(x: 15.5, y: 12),
                        .init(x: 11.25, y: 12),
                        .init(x: 11, y: 11.75),
                        .init(x: 10.5, y: 9),
                        .init(x: 10, y: 8.75),
                        .init(x: 9.5, y: 9),
                        .init(x: 8.5, y: 14.5),
                        .init(x: 8, y: 14.75),
                        .init(x: 7.5, y: 14.5),
                        .init(x: 6.5, y: 8),
                        .init(x: 6, y: 7.75),
                        .init(x: 5.5, y: 8),
                        .init(x: 5, y: 11.75),
                        .init(x: 4.75, y: 12),
                        .init(x: 0, y: 12)
                    ])
                }
                .trim(from: animateTrimPath ? 1/0.99 : 0, to: animateTrimPath ? 1/0.99 : 1)
                .scale(my_scale, anchor: .topLeading)
                .stroke(Color.red, lineWidth: 20)
               .offset(x: -x_offset, y: y_offset)
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                   
                .onAppear() {
                    self.animateTrimPath.toggle()
                }
            }
            .scaleEffect(0.3, anchor: .center)
            .onAppear(){
                self.rotateInfinity.toggle()
            }

            //lower arc
            
            ZStack {
                Path { path in
                    path.addLines([
                        
                         .init(x: 14, y: 15),
                         .init(x: 12, y: 17),
                         .init(x: 10, y: 18),
                         .init(x: 8, y: 18.5),
                         .init(x: 6, y: 18),
                         .init(x: 4, y: 17),
                         .init(x: 2, y: 15)
                ])
                }
                
                .scale(my_scale, anchor: .topLeading)
                .stroke(Color.red, lineWidth: 20)
                .offset(x: -x_offset, y: y_offset)
                .onAppear() {
                    self.animateTrimPath.toggle()
                    
                }
            }
            .scaleEffect(0.3, anchor: .center)
            
        }
        
    }
}


struct SplashScreen2_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen2()
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

