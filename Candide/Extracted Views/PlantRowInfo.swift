//
//  PlantRowInfo.swift
//  Candide
//
//  Created by apprenant90 on 18/09/2025.
//

import SwiftUI

struct PlantRowInfo: View {

    var plantValue: String
    var plantText: String
    var plantIco: String

    var body: some View {
        
        HStack {
            Text(plantIco + " ")
            Text (plantText + ": ")
            Text (plantValue)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.cPink)
        .cornerRadius(8)
        .padding(.horizontal)
        
    }
    
}

#Preview {
    PlantRowInfo(plantValue: "0", plantText: "toto", plantIco: "plus" )
}
