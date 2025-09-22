//
//  Program.swift
//  Candide
//
//  Created by apprenant95 on 16/09/2025.
//

import SwiftUI

struct Program: View {

    @State var task: [PlantTask] = tasks
    @State var selectedDate: Date = Date()
    var filteredTasks: [PlantTask] {
        tasks.filter {
            $0.date == selectedDate.formatted(date: .numeric, time: .omitted)
        }
    }
    @ObservedObject var taskList = taskListGlobalVar


    var body: some View {
        NavigationStack {
            ZStack {
                Color.cGreen
                    .ignoresSafeArea()
                VStack {
                    //  Date et tâches
                    DateNavigationView(selectedDate: $selectedDate)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(16)
                        .padding()

                    HStack {
                        Text("Mes tâches")
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

                        if filteredTasks.isEmpty {

                            HStack {
                                Spacer()
                                Image(systemName: "cloud.sun.fill")
                                    .padding()
                                Text("Rien à faire pour aujourd’hui !")
                                    .font(.headline)
                                Spacer()
                            }.foregroundColor(.cYellow).padding(.vertical, 40)
                                .transition(.opacity.combined(with: .scale))

                        } else {
                            //     Liste des tasks
                            ScrollView(showsIndicators: false) {
                                //     Liste des tasks
                                ScrollView(showsIndicators: false) {
                                    ForEach(taskList.taskList) { myTask in
                                        if let plant = plantListGlobalVar.plantList
                                            .first(where: { $0.id == myTask.plantID })
                                        {
                                            ProgramRow(task: myTask, plant: plant)
                                        }
                            }.transition(.move(edge: .leading))
                        }
                    }

                }
                .padding(.horizontal, 30)

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
            .animation(.easeInOut(duration: 0.2), value: filteredTasks.count)
        }

    }
}

#Preview {
    Program()
}
