//
//  AnalyzeView.swift
//  atria_secondtry
//
//  Created by Jeffrey Chen on 4/17/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

struct AnalyzeView: View {
    var body: some View {
        VStack{
        
            Button(action: {
                print("analyze")
                //use ML model here, once it is clicked show the loading symbol
                //splash screen for loading?
            })
            {
                Text("analyze")
            }
            
            Button(action: {
                print("discard")
                //
            })
            {
                Text("Discard Item")
            }
        }
    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
