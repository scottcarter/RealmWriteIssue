//
//  Note.swift
//  RealmWriteIssue
//
//  Created by Scott Carter on 10/11/20.
//

import Foundation
import RealmSwift

class Note: Object {

    @objc dynamic var noteId = UUID().uuidString
    @objc dynamic var title: String = ""

    override class func primaryKey() -> String? {
        return "noteId"
    }
}
