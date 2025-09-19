//
//  PlantRowAlert.swift
//  Candide
//
//  Created by apprenant90 on 18/09/2025.
//

import SwiftUI

struct PlantRowAlert: View {
    
    @Binding var task: PlantTask
    
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
                        task.isDone.toggle()
                    } label: {
                        ZStack {
                            Image(systemName:"circle.fill")
                                .foregroundStyle(.gray.opacity(0.3))
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isDone ? .cGreen : .gray)
                        }
                    }
                    
                }   .padding()
                    .background(Color.cPink)
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                
            }
            .padding(.vertical,8)
            
            Spacer()
            
        }
        
    }
    
}

#Preview { PlantRowAlert(task: .constant(tasks[0])) }
