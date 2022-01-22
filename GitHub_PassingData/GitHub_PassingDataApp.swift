//
//  GitHub_PassingDataApp.swift
//  GitHub_PassingData
//
//  Created by G RT on 1/22/22.
//

import SwiftUI

@main
struct GitHub_PassingDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Users())
        }
    }
}
