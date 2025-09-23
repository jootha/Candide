//
//  EditTaskView.swift
//  Candide
//
//  Created by apprenant90 on 20/09/2025.
//

import SwiftUI

struct EditTaskView: View {
    @FocusState private var isTextFieldFocused: Bool
    @State var taskDate: Date = Date()
    @ObservedObject var myTask: PlantTask
    @ObservedObject var taskList = taskListGlobalVar
    @State var repeatInterval: RepeatInterval = .none
    @Environment(\.dismiss) var dismiss
    @State var tmpName: String
    @State var tmpTask: Bool

    var dateStringFormatter: DateFormatter {
        let formatter = DateFormatter()

        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.cGreen.ignoresSafeArea()

                Form {
                    TextField("Nom de la tâche", text: $tmpName)
                        .focused($isTextFieldFocused)
                        .onAppear {self.isTextFieldFocused = true}
                    
                    DatePicker(
                        "Date",
                        selection: Binding(
                            get: {
                                dateStringFormatter.date(from: myTask.date) ?? Date()
                            },
                            set: { newDate in
                                myTask.date = dateStringFormatter.string(from: newDate)
                            }
                        ),
                        displayedComponents: .date
                    )
                    
                    Picker("Répétition", selection: $repeatInterval) {
                        ForEach(RepeatInterval.allCases, id: \.self) { interval in
                            Text(interval.rawValue).tag(interval)
                        }
                    }
                    
                    Toggle("Déjà effectuée", isOn: $myTask.isDone)
                    
                }

            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        dismiss()
                        myTask.name = tmpName
                        myTask.date = dateStringFormatter.string(from: taskDate)
                        myTask.isDone = tmpTask
                    }
                    .disabled(myTask.name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .tint(.white)

                }
            }
            .navigationTitle("Modifier la tâche")
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    
    NavigationStack {
        EditTaskView(
            myTask: taskListGlobalVar.taskList[0],
            tmpName: "Tache Test",
            tmpTask: false
        )}
}
