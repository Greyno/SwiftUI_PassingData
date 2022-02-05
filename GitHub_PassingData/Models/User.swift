//
//  User.swift
//  GitHub_PassingData
//
//  Created by G RT on 1/22/22.
//

import Foundation

//Change the User from a struct to a class so that now we have a ModelObject
//By making User an ObservableObject, a User will listen to changes to its published variables and when that happens, anything observing the user can respond
//So when we make changes in one view, those changes will be observed in another view
//Conform @Publishable items to codable: https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties

class User: ObservableObject, Identifiable, Codable, Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(firstName)
        hasher.combine(lastName)
    }
    
    
    @Published var id = UUID()
    @Published var firstName: String
    @Published var lastName: String
    
    //Functions for adding codable conformance for the @Published properties: CodingKeys, decoder and encoder containers
    enum CodingKeys: CodingKey {
        case firstName, lastName, id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(id, forKey: .id)
    }
    
    //To help with our SwiftUI previews, create an init with default values
    init(firstName: String = "Timothy", lastName: String = "Lane") {
        self.firstName = firstName
        self.lastName = lastName
    }
}
