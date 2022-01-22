//
//  DetailView.swift
//  GitHub_PassingData
//
//  CCreated by G RT on 1/22/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var user: User
    @EnvironmentObject var users: Users
    
    var body: some View {
        VStack {
            TextField("First name", text: $user.firstName)
            TextField("First name", text: $user.lastName)
        }.padding()
        .onDisappear {
            users.update(userToChange: user)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User()).environmentObject(Users())
    }
}
