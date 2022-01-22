//
//  ContentView.swift
//  GitHub_PassingData
//
//  Created by G RT on 1/22/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var users: Users
    @State private var showUser = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users.userStore) { user in
                    UserRowView(user: user)
                }.onDelete { indexSet in
                    users.deleteUser(at: indexSet)
                }
            }
            .navigationTitle("Users")
            .navigationBarItems(trailing: Button(action: { showUser = true }) {
                            Image(systemName: "plus")
                          })
                    }.fullScreenCover(isPresented: $showUser, content: {
                        UserInputView()
                    })
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Users())
    }
}
