//
//  Program.swift
//  Candide
//
//  Created by apprenant95 on 16/09/2025.
//

import SwiftUI

struct Program: View {
    
    @State var task: [PlantTask] = tasks
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cGreen
                    .ignoresSafeArea()
                VStack {
                    //  Date et tâches
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
                            .shadow(radius:2)
                        Spacer()
                    }
                    ZStack(alignment: .topLeading) {
                        VStack {
                            Rectangle()
                                .fill(Color.cYellow.opacity(0.5))
                                .frame(width: 2)
                                .frame(maxHeight: .infinity)
                        }
                        .padding(.leading, 4)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        //     Liste des tasks
                        ScrollView (showsIndicators: false){
                            
                            ForEach($task.indices, id: \.self) { index in
                                    let task = tasks[index]
                                    if let plant = plantListGlobalVar.plantList.first(where: { $0.id == task.plantID }) {
                                        ProgramRow(task: $task[index], plant: plant)
                                    }
                                }
                            }
                        }
                        
                    } .padding(.horizontal,30)
                }
            //            Nav Bar
                        .navigationBarTitleDisplayMode(.inline)
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
