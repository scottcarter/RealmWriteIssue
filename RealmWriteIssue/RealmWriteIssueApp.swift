//
//  RealmWriteIssueApp.swift
//  RealmWriteIssue
//
//  Created by Scott Carter on 10/11/20.
//

import RealmSwift
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true

        Realm.Configuration.defaultConfiguration = config


        let realm: Realm
        do {
          realm = try Realm()
        } catch let error {
          fatalError("Failed to open Realm. Error: \(error.localizedDescription)")
        }

        let noteModel = NoteModel(realm: realm)

        noteModel.deleteAll()
        noteModel.writeNotes(count: 2000)

        return true
    }
}

@main
struct RealmWriteIssueApp: App {

    // How to inject App Delegate in iOS 14:  https://tinyurl.com/y6dyawy9
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
