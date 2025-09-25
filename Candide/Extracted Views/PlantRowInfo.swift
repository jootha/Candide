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

        HStack(alignment: .top, spacing: 8) {
            Text(plantIco)
                .font(.system(size: 24))

            VStack(alignment: .leading, spacing: 2) {
                if(plantText == "Interieur" || plantText == "Extérieur"){
                    Text(plantText)
                        .font(.footnote)
                        .bold()
                        .padding(.top, 6)
                } else {
                    Text(plantText + ":")
                        .font(.footnote)
                        .bold()
                    Text(plantValue)
                        .font(.footnote)
                }}

            Spacer()
        }
        .frame(height:10, alignment: .leading)
        .padding()
        .background(Color.cPink)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

#Preview { PlantRowInfo(plantValue: "Youpiiiiiiiiiii tous les 10jrs...", plantText: "Detailssssssss", plantIco: "🌱") }
