//
//  Garden.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//

import SwiftUI

struct Garden: View {
    var body: some View {
        VStack {
            Text("Jardin")
            
            ZStack{
                Color.cGreen.ignoresSafeArea()
                
                VStack {
                    ZStack{
                        Rectangle().fill(.cOrange)
                            .frame(width: 350, height: 200)
                            .cornerRadius(16)
                            .padding()
                        
                        Rectangle()
                            .foregroundStyle(.cDarkBlue)
                            .frame(width: 300, height: 150)
                        
                        HStack{
                            Spacer()
                            ZStack{
                                Circle().frame(width: 30)
                                    .opacity(0.60)
                                    .foregroundColor(.gray)
                                Image(systemName: "heart.fill")
                            }
                            Spacer()
                        }.frame(maxWidth: 350)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    Garden()
}
