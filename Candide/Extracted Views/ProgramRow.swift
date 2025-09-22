//
//  ProgramRow.swift
//  Candide
//
//  Created by apprenant95 on 16/09/2025.
//

import SwiftUI

struct ProgramRow: View {
    @ObservedObject var task: PlantTask
    var plant: Plant
    @ObservedObject var taskList = taskListGlobalVar
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(Color.cYellow)
                .frame(width: 10, height: 10)
                .padding(.top, 38)
            
            VStack {
                HStack {
                    Text(task.name)
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if task.isDone {
                                task.isDone = false
                            } else {
                                task.isDone = true
                                if let nextDate = task.nextDate(),
                                   task.repeatInterval != .none
                                {
                                    let newDateString =
                                    taskDateFormatter.string(from: nextDate)
                                    let repeatedTask = PlantTask(
                                        name: task.name,
                                        date: newDateString,
                                        isDone: false,
                                        plantID: task.plantID,
                                        repeatInterval: task.repeatInterval
                                    )
                                    
                                    taskList.taskList.append(repeatedTask)
                                }
                            }
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.gray.opacity(0.3))
                            Image(
                                systemName: task.isDone
                                ? "checkmark.circle.fill" : "circle"
                            )
                            .foregroundColor(task.isDone ? .cGreen : .gray)
                        }
                    }
                }
                .padding()
                .background(Color.cPink)
                .cornerRadius(8)
                .padding(.horizontal)
                
                if let image = plant.imageName {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .padding()
                        .shadow(radius: 5)
                } else {
                    Image("default")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .padding()
                        .shadow(radius: 5)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.cYellow)
            .cornerRadius(24)
            .shadow(radius: 2)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ProgramRow(
        task: taskListGlobalVar.taskList[0],
        plant: plantListGlobalVar.plantList[0]
    )
}
