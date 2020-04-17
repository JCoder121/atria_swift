//
//  ThirdView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/16/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

struct AboutUsView: View {
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
