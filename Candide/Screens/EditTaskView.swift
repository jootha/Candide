//
//  EditTaskView.swift
//  Candide
//
//  Created by apprenant90 on 20/09/2025.
//

import SwiftUI

struct EditTaskView: View {
    @State var taskDate: Date = Date()
    @ObservedObject var myTask: PlantTask
    @ObservedObject var taskList = taskListGlobalVar
    @Environment(\.dismiss) var dismiss

    var dateStringFormatter: DateFormatter {
        let formatter = DateFormatter()

        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Nom de la tâche", text: $myTask.name)
                
                DatePicker(
                    "Date",
                    selection: $taskDate,
                    displayedComponents: .date
                )
                
                Toggle("Déjà effectuée", isOn: $myTask.isDone)

            }
            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Annuler") {
//                        dismiss()
//                    }
//                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        dismiss()
                        myTask.date = dateStringFormatter.string(from: taskDate)
                   }
                    .disabled(myTask.name.trimmingCharacters(in: .whitespaces).isEmpty)

                }
            }
            .navigationTitle("Modifier la tâche")
        }
    }
}

#Preview {
    NavigationStack {
        EditTaskView(
            myTask: taskListGlobalVar.taskList[0]
        )}}
