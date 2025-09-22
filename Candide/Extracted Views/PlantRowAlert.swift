//
//  PlantRowAlert.swift
//  Candide
//
//  Created by apprenant90 on 18/09/2025.
//

import SwiftUI

struct PlantRowAlert: View {
    @ObservedObject var myTask: PlantTask
    @State private var showEdit = false

    var body: some View {
        
        HStack(alignment: .top, spacing: 16) {
            Button {
                showEdit = true
            } label: {
                Circle()
                    .fill(Color.cYellow)
                    .frame(width: 10, height: 10)
                    .padding(.top, 38)

                VStack {
                    HStack {
                        TrashTaskButton(myTask: myTask)
                        Text(myTask.name)
                        Spacer()
                        Button {
                            myTask.isDone.toggle()
                        } label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.gray.opacity(0.3))
                                Image(
                                    systemName: myTask.isDone
                                        ? "checkmark.circle.fill" : "circle"
                                )
                                .foregroundColor(
                                    myTask.isDone ? .cGreen : .gray
                                )
                            }
                        }
                    }
                    .padding()
                    .background(Color.cPink)
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)

                Spacer()
            }
            .navigationDestination(isPresented: $showEdit) {
                EditTaskView(myTask: myTask)
            }
        }
    }
}

#Preview {PlantRowAlert(myTask: taskListGlobalVar.taskList[0])}
