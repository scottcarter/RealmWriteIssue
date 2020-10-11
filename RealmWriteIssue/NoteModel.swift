//
//  NoteModel.swift
//  RealmWriteIssue
//
//  Created by Scott Carter on 10/11/20.
//

import Foundation
import RealmSwift

class NoteModel {

    // MARK: - Constants

    let realm: Realm

    // MARK: - Variable Properties

    private lazy var noteResults: Results<Note> = {
        getNoteResults()
    }()

    private var subscription: NotificationToken?

    private var sortDescriptors = [SortDescriptor(
                                    keyPath: "title",
                                    ascending: true
    )]

    // MARK: - Initializers

    init(realm: Realm) {
        self.realm = realm

        noteResults = getNoteResults()
    }

    // MARK: - Functions

    func deleteAll() {
        var tokens = [NotificationToken]()

        if let subscription = subscription {
            tokens = [subscription]
        }

        do {
            try realm.write(withoutNotifying: tokens) {
                realm.deleteAll()
            }
        } catch {
            assertionFailure("Could not write to realm")
        }
    }

    func writeNotes(count: Int) {
        for index in 0..<count {
            let title = "title\(index)"
            create(title: title)
        }

    }

}

private extension NoteModel {

    func create(title: String) {

        let noteEntity = Note()
        noteEntity.title = title

        var tokens = [NotificationToken]()

        if let subscription = subscription {
            tokens = [subscription]
        }

        do {
            try realm.write(withoutNotifying: tokens) {
                realm.add(noteEntity)
            }
        } catch {
            assertionFailure("Could not write to realm")
        }
    }

    func getNoteResults() -> Results<Note> {
        let results = realm.objects(Note.self)
                .sorted(by: sortDescriptors)

        subscription = notificationSubscription(noteResults: results)
        return results
    }

    func notificationSubscription(noteResults: Results<Note>) -> NotificationToken {
        return noteResults.observe {[weak self] (changes: RealmCollectionChange<Results<Note>>) in
            self?.notify(changes: changes)
        }
    }

    func notify(changes: RealmCollectionChange<Results<Note>>) {
        switch changes {

        case .initial:
            break

        case .update(_, let deletions, let insertions, let modifications):

            print("\nNoteModel: Processing ",
                  "\n", deletions.count, " deletions = ", deletions,
                  "\n", insertions.count, " insertions = ", insertions,
                  "\n", modifications.count, " modifications = ", modifications)

        case .error(let error):
            print(error)
        }
    }
}
