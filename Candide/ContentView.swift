//
//  ContentView.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//
/*Tab bar only */
import SwiftUI

struct ContentView: View {

    init() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
                    .defaultTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.cDarkBlue, 
                        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)

                    ]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .cYellow
    }

    var body: some View {
        //Tab Bar
        TabView {
            Group {
                Garden()

                    .tabItem {
                        Text("Mon Jardin")
                        Image(systemName: "leaf.circle.fill")
                    }

                Program()
                    .tabItem {
                        Text("Programme")
                        Image(systemName: "calendar.circle.fill")
                    }
                
                ForumView()
                    .tabItem {
                        Text("Forum")
                        Image(systemName: "message.circle.fill")
                    }
            }.toolbarBackground(.cDarkBlue, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)

        }
    }
}

#Preview {
    ContentView()
}
