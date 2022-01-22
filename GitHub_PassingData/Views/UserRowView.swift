//
//  UserRowView.swift
//  GitHub_PassingData
//
//  Created by G RT on 1/22/22.
//

import SwiftUI

struct UserRowView: View {
    @ObservedObject var user: User
    
    var body: some View {
        NavigationLink(
            destination: DetailView(user: user),
            label: {
                HStack {
                    Image(systemName: "bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text(user.firstName)
                        Text(user.lastName)
                    }
                   
                }
            })
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User())
    }
}
