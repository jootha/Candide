import SwiftUI

struct AddTaskView: View {
    @FocusState private var isTextFieldFocused: Bool
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
            ZStack {
                Color.cGreen.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        
                        // Champ Nom
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Nom de la tâche")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.cPink)
                                .cornerRadius(12)
                                .shadow(radius: 2)

                            TextField("Arroser la plante…", text: $taskName)
                                .focused($isTextFieldFocused)
                                .padding()
                                .frame(height: 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.cYellow)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        }
                        .padding()
                        .background(Color.cYellow)
                        .cornerRadius(16)
                        .shadow(radius: 3)
                        .onAppear { self.isTextFieldFocused = true }
                        
                        // Date Picker
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Date")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.cPink)
                                .cornerRadius(12)
                                .shadow(radius: 2)

                            DatePicker("", selection: $taskDate, displayedComponents: .date)
                                .labelsHidden()
                                .padding()
                                .frame(height: 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.cYellow)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        }
                        .padding()
                        .background(Color.cYellow)
                        .cornerRadius(16)
                        .shadow(radius: 3)
                        
                        // Picker répétition
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Répétition")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.cPink)
                                .cornerRadius(12)
                                .shadow(radius: 2)

                            Picker("", selection: $repeatInterval) {
                                ForEach(RepeatInterval.allCases, id: \.self) { interval in
                                    Text(interval.rawValue).tag(interval)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding()
                            .frame(height: 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.cYellow)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        }
                        .padding()
                        .background(Color.cYellow)
                        .cornerRadius(16)
                        .shadow(radius: 3)
                        
                        // Toggle
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Statut")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.cPink)
                                .cornerRadius(12)
                                .shadow(radius: 2)

                            Toggle("Déjà effectuée", isOn: $isDone)
                                .padding()
                                .frame(height: 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.cYellow)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        }
                        .padding()
                        .background(Color.cYellow)
                        .cornerRadius(16)
                        .shadow(radius: 3)
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 30)
                }
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
                    .disabled(taskName.trimmingCharacters(in: .whitespaces).isEmpty)
                    .tint(.white)
                }
            }
            .navigationTitle("Nouvelle tâche")
//            .toolbarBackground(.cDarkBlue, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
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
