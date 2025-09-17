//
//  Program.swift
//  Candide
//
//  Created by apprenant95 on 16/09/2025.
//

import SwiftUI

struct Program: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cGreen
                    .ignoresSafeArea()
                VStack {
                    //  Mettre la date
                    Text("26/01/2025")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(16)
                        .padding(.vertical)
                    
                    HStack {
                        Text("Mes tâches")
                            .padding(10)
                            .font(.subheadline)
                            .background(Color.cYellow)
                            .cornerRadius(16)
                            .padding(.horizontal,30)
                            .shadow(radius:2)
                        Spacer()
                    }
                    
                    ScrollView (showsIndicators: false){
                        ForEach (tasks.indices, id: \.self) { index in
                            ProgramRow(task: tasks[index], plant: plantListGlobalVar.plantList[index])
                        } .padding(.vertical,8)
                        
                    } .padding(.horizontal,30)
                }
            }       .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Programme")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
            .toolbarBackground(.cDarkBlue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        }
    }

#Preview {
    Program()
}
