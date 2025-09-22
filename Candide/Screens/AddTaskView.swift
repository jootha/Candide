import SwiftUI

struct AddTaskView: View {
    @ObservedObject var plant: Plant
    @Binding var navPath: NavigationPath
    @State var taskName: String = ""
    @State var taskDate: Date = Date()
    @State var isDone: Bool = false
    @State var repeatInterval: RepeatInterval = .none
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
                TextField("Nom de la tâche", text: $taskName)

                DatePicker(
                    "Date",
                    selection: $taskDate,
                    displayedComponents: .date
                )

                Picker("Répétition", selection: $repeatInterval) {
                    ForEach(RepeatInterval.allCases, id: \.self) { interval in
                        Text(interval.rawValue).tag(interval)
                    }
                }

                Toggle("Déjà effectuée", isOn: $isDone)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Enregistrer") {
                        dismiss()
                        let newTask = PlantTask(
                            name: taskName,
                            date: dateStringFormatter.string(from: taskDate),
                            isDone: isDone,
                            plantID: plant.id,
                            repeatInterval: repeatInterval
                        )
                        taskList.taskList.append(newTask)
                    }
                }
            }
            .navigationTitle("Nouvelle tâche")
        }
    }
}

#Preview {
    NavigationStack {
        AddTaskView(
            plant: plantListGlobalVar.plantList[0],
            navPath: .constant(NavigationPath())
        )
    }
}

