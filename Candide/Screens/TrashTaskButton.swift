//
//  TrashTaskButton.swift
//  Candide
//
//  Created by apprenant90 on 20/09/2025.
//

import SwiftUI

struct TrashTaskButton: View {
    @State var myTask: PlantTask
    @ObservedObject var taskList = taskListGlobalVar
    @State var showingAlert = false

    var body: some View {
        Button {
            showingAlert = true
        } label: {
            ZStack {
                Circle().frame(width: 30)
                    .foregroundColor(.cDarkBlue)

                Image(systemName: "trash")
                    .opacity(0.8)
                    .foregroundColor(.cOrange)
                    .font(.system(size: 15))

            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Supprimer !"),
                message: Text("Etes-vous sûr de vouloir supprimer " + myTask.name + " ?"),
                primaryButton: .destructive(Text("Supprimer")) {
                    taskList.removeTask(myTask)
                },
                secondaryButton: .cancel(Text("Annuler"))
            )
        }
    }
}

#Preview { TrashTaskButton(myTask: taskListGlobalVar.taskList[0]) }
