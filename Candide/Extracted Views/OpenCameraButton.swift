//
//  OpenCameraButton.swift
//  Candide
//
//  Created by apprenant84 on 23/09/2025.
//

import SwiftUI

struct OpenCameraButton: View {
    var body: some View {
        @StateObject var photoViewModel = PhotoViewModel()
        @State var showCamera = false

        Button {
            showCamera = true
        } label: {
            Label("Plus", systemImage: "photo")
                .labelStyle(.iconOnly)
                .padding(16)
                .background(.cDarkBlue)
                .foregroundStyle(.cOrange)
                .cornerRadius(32)
                .font(.system(size: 32))
                .bold()
        }.sheet(isPresented: $showCamera) {
            CameraScreen(viewModel: photoViewModel)
        }
    }
}

#Preview {
    OpenCameraButton()
}
