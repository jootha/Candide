//
//  ContentView.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Jardin")
            
            ZStack{
                Color.green.ignoresSafeArea()
                
                VStack {
                    ZStack{
                        Rectangle().fill(Color.yellow)
                            .frame(width: 350, height: 200)
                            .cornerRadius(16)
                            .padding()
                        
                        Rectangle()
                            .foregroundStyle(.blue)
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
    ContentView()
}
