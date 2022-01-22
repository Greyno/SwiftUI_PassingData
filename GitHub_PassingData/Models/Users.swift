//
//  Users.swift
//  GitHub_PassingData
//
//  Created by G RT on 1/22/22.
//

import Foundation

import SwiftUI
import Combine

class Users: ObservableObject {

    var userStore: [User] { usersCache }

    @Published var usersCache = [User]() {
        didSet {
            guard let data = try? JSONEncoder().encode(usersCache.self) else { return }
            UserDefaults.standard.set(data, forKey: "Users")
            for user in usersCache {
                print("The saved user is \(user.firstName) \(user.lastName)")
            }
        }
    }
    
    init() {

        if let users = UserDefaults.standard.data(forKey: "Users") {
            if let decoded = try? JSONDecoder().decode([User].self, from: users) {
                self.usersCache = decoded
                return
            }
        }
        self.usersCache = []
        }
    
    func addUser(user: User) {
        print("Running the user is add function")
        usersCache.insert(user, at: 0)
    }
    
    func deleteUser(at offsets: IndexSet) {
        usersCache.remove(atOffsets: offsets)
    }
    
    func update(userToChange: User) {
        let foundIndex = usersCache.firstIndex { (user) -> Bool in
            user.firstName == userToChange.firstName && user.lastName == userToChange.lastName
        }
        usersCache[foundIndex!] = userToChange
    }
}

