//
//  PlantRowTask.swift
//  Candide
//
//  Created by apprenant90 on 23/09/2025.
//

import SwiftUI

struct PlantRowTask: View {

    @ObservedObject var myTask: PlantTask
    @State private var showEdit = false

    var body: some View {

        HStack() {
            Button {
                showEdit = true
            } label: {
                VStack {
                    HStack(alignment: .center) {
                        TrashTaskButton(myTask: myTask)

                        Text(myTask.name)
                            .font(.headline)

                        Spacer()

                        Button {
                            myTask.isDone.toggle()
                        } label: {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.gray.opacity(0.3))

                                Image(systemName: myTask.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(myTask.isDone ? .cGreen : .gray)
                            }
                        }
                    }
                    .padding()
                    .background(Color.cPink)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .navigationDestination(isPresented: $showEdit) {
                EditTaskView(
                    myTask: myTask,
                    tmpName: "",
                    tmpTask: false
                )
            }
        }
    }
}

#Preview {PlantRowTask(myTask: taskListGlobalVar.taskList[0])}
