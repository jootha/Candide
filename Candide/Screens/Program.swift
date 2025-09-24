//
//  Program.swift
//  Candide
//
//  Created by apprenant95 on 16/09/2025.
//

import SwiftUI

struct Program: View {

    @ObservedObject var taskList = taskListGlobalVar
    @State var selectedDate: Date = Date()

    var todayString: String {
        return selectedDate.formatted(date: .numeric, time: .omitted)
    }
    var pending : [PlantTask] {
        return taskList.pendingTasks(for: selectedDate)
        
    }
    var done : [PlantTask] {
        return taskList.doneTasks(for: selectedDate)
    }
    
    @State var isChange: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cGreen.ignoresSafeArea()

                VStack {
                    // Navigation par date
                    DateNavigationView(selectedDate: $selectedDate)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(16)
                        .padding()

                    HStack {
                        Text("Mes tâches à faire")
                            .padding(10)
                            .font(.subheadline)
                            .background(Color.cYellow)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                            .padding(.horizontal)
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

                        ScrollView(showsIndicators: false) {

                            if pending.isEmpty && done.isEmpty {
                                HStack {
                                    Spacer()
                                    Image(systemName: "cloud.sun.fill")
                                        .padding()
                                    Text("Rien à faire pour aujourd’hui !")
                                        .font(.headline)
                                    Spacer()
                                }
                                .foregroundColor(.cYellow)
                                .padding(.vertical, 40)
                                .transition(.opacity.combined(with: .scale))
                            } else {
                                ForEach(pending) { myTask in
                                    if let plant = plantListGlobalVar.plantList
                                        .first(where: {
                                            $0.id == myTask.plantID
                                        })
                                    {
                                        ProgramRow(task: myTask, plant: plant, isChange: $isChange)
                                            
                                    }
                                }

                                if !done.isEmpty {
                                    HStack {
                                        Text("Tâches effectuées")
                                            .padding(10)
                                            .font(.subheadline)
                                            .background(Color.cYellow)
                                            .cornerRadius(16)
                                            .shadow(radius: 2)
                                            .padding(.horizontal)
                                        Spacer()
                                    }.padding(.top,30)
                                        .padding(.leading, 20)

                                    ForEach(done) { myTask in
                                        if let plant = plantListGlobalVar
                                            .plantList.first(where: {
                                                $0.id == myTask.plantID
                                            })
                                        {
                                            ProgramRow(
                                                task: myTask,
                                                plant: plant,
                                                isChange: $isChange
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .transition(.move(edge: .leading))
                        
                    }
                    .id(isChange)
                }
                .padding(.horizontal, 30)
            }
//            .onChange(of: isChange){ new in
//              //  pending = taskList.pendingTasks(for: selectedDate)
//                print(isChange.description)
//            }

            // Nav bar
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
