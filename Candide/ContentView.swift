//
//  ContentView.swift
//  Candide
//
//  Created by apprenant84 on 15/09/2025.
//
/*Tab bar only */
import SwiftUI

struct ContentView: View {
    var body: some View {
        //Tab Bar
                TabView {
                    Garden()
                        .tabItem {
                            Text("Mon Jardin")
                            Image(systemName: "leaf.circle.fill")
                        }
                    AddPostView()
                        .tabItem {
                            Text("Forum")
                            Image(systemName: "message.circle.fill")
                        }
                }
            }
        }

#Preview {
    ContentView()
}
