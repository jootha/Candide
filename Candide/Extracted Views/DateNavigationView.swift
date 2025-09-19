//
//  DateNavigationView.swift
//  Candide
//
//  Created by apprenant95 on 18/09/2025.
//

import SwiftUI

struct DateNavigationView: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                } label: {
                    Image(systemName:"arrow.backward")
                }
                
                Text(selectedDate.formatted(date: .numeric, time: .omitted))
                    .font(.headline)
                    .padding()
                
                Button {
                    selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                } label: {
                    Image(systemName:"arrow.forward")
                }
                }
            .padding(.horizontal)
            .foregroundStyle(.white)
            }
        }
    }


#Preview {
    DateNavigationView(selectedDate: .constant(Date()))
    .background(Color.cGreen)
}
