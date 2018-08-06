//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Zachary Frew on 8/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    // MARK: - Singleton
    static let shared = EntryController()
    
    // MARK: - Properties
    var entries: [Entry] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Methods
    func save(entry: Entry, completion: @escaping ((_ success: Bool) -> ())) {
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print("Error occurred saving entry record: \(error.localizedDescription).")
                completion(false)
                return
            }
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, bodyText: String, completion: @escaping ((_ success: Bool) -> ())) {
        let entry = Entry(title: title, bodyText: bodyText)
        save(entry: entry) { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Entry.TypeKey, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error occurred fetching entry records: \(error.localizedDescription).")
                completion(false)
                return
            }
            guard let records = records else { completion(false) ; return }
            let entries = records.compactMap { Entry(cloudKitRecord: $0) }
            self.entries = entries
            completion(true)
        }
    }
    
    func delete(entry: Entry) {
        if let entryIndex = entries.index(of: entry) {
            entries.remove(at: entryIndex)
        }
        privateDB.delete(withRecordID: entry.ckRecordID) { (_, error) in
            if let error = error {
                print("Error occurred deleting record: \(error.localizedDescription).")
                return
            }
        }
    }
    
}
