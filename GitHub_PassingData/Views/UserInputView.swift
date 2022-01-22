//
//  UserInputView.swift
//  GitHub_PassingData
//
//  Created by G RT on 1/22/22.
//

import SwiftUI

struct UserInputView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var users: Users
    @ObservedObject var user = User(firstName: "", lastName: "")
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User")) {
                    TextField("First name", text: $user.firstName)
                    TextField("Last name", text: $user.lastName)
                }
            }
            .navigationBarTitle("User Details", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                //let user = User(firstName: firstname, lastName: lastname)
                users.addUser(user: user)
                presentationMode.wrappedValue.dismiss()
            }.disabled([user.firstName, user.lastName].contains(where: \.isEmpty))
            )
        }
        
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView().environmentObject(Users())
    }
}
