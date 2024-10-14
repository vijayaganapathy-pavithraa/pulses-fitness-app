//
//  ReferencePage.swift
//  WorkoutPage
//
//  Created by Tessa on 4/8/24.
//

import SwiftUI

struct Secties {
    let name: String
    let color: Color
}

struct ReferencePage: View {
    
    var sectiesList = [
        Secties(name: "Very Easy - Little to no prior experience", color: Color.blue),
        Secties(name: "Easy - A few weeks or months of practice", color: Color.green),
        Secties(name: "Moderate - Several months to a year of practice", color: Color.yellow),
        Secties(name: "Difficult - At least a year of regular practice", color: Color.orange),
        Secties(name: "Very Difficult - Several years of regular practice", color: Color.red)
    ]
    
    var body: some View {
        
        VStack {
            Text(" ")
                .font(.largeTitle)
            Text(" ")
            Text("Find out your yoga level!")
                .font(.title)
                .bold()
            List(sectiesList, id: \.name) { secties in
                
                HStack(alignment: .center) {
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(secties.color)
                        .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10, alignment: .center)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    
                    Text(secties.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                
            }
            .scrollContentBackground(.hidden)
            .edgesIgnoringSafeArea(.all)
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.purplePulses, .blue2Pulses]), startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    ReferencePage()
}
