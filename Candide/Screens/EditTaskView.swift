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
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // Nom de la tâche
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Nom de la tâche")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.cPink)
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                            TextField("Nom", text: $tmpName)
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
                        
                        // Date
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
                        
                        // Répétition
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
                        
                        // Statut
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Statut")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.cPink)
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            
                            Toggle("Déjà effectuée", isOn: $tmpTask)
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
                        myTask.name = tmpName
                        myTask.date = dateStringFormatter.string(from: taskDate)
                        myTask.repeatInterval = repeatInterval
                        myTask.isDone = tmpTask
                        dismiss()
                    }
                    .disabled(myTask.name.trimmingCharacters(in: .whitespaces).isEmpty)
                    .tint(.white)
                }
            }
            .navigationTitle("Modifier la tâche")
//            .toolbarBackground(.cDarkBlue, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                tmpName = myTask.name
                tmpTask = myTask.isDone
                repeatInterval = myTask.repeatInterval
                taskDate = dateStringFormatter.date(from: myTask.date) ?? Date()
                isTextFieldFocused = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        EditTaskView(
            myTask: taskListGlobalVar.taskList[0],
            tmpName: "",
            tmpTask: false
        )
    }
}
