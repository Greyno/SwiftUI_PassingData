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

    //Load/save files from/to the Document directory, instead of from the app bundle
   let usersJsonUrl = URL(fileURLWithPath: "UserNames", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    @Published var usersCache = [User]() {
        didSet {
            saveUserNames()
        }
    }
    
    init() {

        loadUserNames()
        }
    
    private func saveUserNames() {
        //Create a Json encoder object
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted //Make the JSON file more readable
        
        //Encode the Swift type into Data then save to the Document Directory URL
        do {
            let usersData = try jsonEncoder.encode(usersCache)
            try usersData.write(to: usersJsonUrl, options: .atomicWrite)
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    private func loadUserNames() {
        print("Document directory url: \(FileManager.documentsDirectoryURL.absoluteURL)")
        //Gracefully handle having no PList file in the documents directory
        guard FileManager.default.fileExists(atPath: usersJsonUrl.path) else { return }
        
        //Create a JSON decoder object
        let jsonDecoder = JSONDecoder()
        
        //Load contents of the PList (from the Document directory URL) as Swift Data, then decode these Data objects to a Swift type
        do {
            let userNamesData = try Data(contentsOf: usersJsonUrl)
            usersCache = try jsonDecoder.decode([User].self, from: userNamesData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addUser(user: User) {
        usersCache.insert(user, at: 0)
        
        for user in usersCache {
            print("The first user is \(user.firstName) \(user.lastName)")
            
        }
        //print("The first user is \(usersCache[0].firstName) \(usersCache[0].lastName)")
    }
    
    func deleteUser(at offsets: IndexSet) {
        usersCache.remove(atOffsets: offsets)
    }
    
//TODO: Add UTs to ensure this function replaces the item expected
    func update(userToChange: User) {
        let foundIndex = usersCache.firstIndex { (user) -> Bool in
            user == userToChange
            //user.firstName == userToChange.firstName && user.lastName == userToChange.lastName
        }
        usersCache[foundIndex!] = userToChange
    }
}

