//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Zachary Frew on 8/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    // MARK: - Properties
    let title: String
    let bodyText: String
    let ckRecordID: CKRecordID
    static let TypeKey = "Entry"
    static let TitleKey = "title"
    static let BodyTextKey = "bodyText"
    static let CKRecordIDKey = "ckRecordID"
    
    // MARK: - Initializers
    init(title: String, bodyText: String, ckRecordID: CKRecordID) {
        self.title = title
        self.bodyText = bodyText
        self.ckRecordID = ckRecordID
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let title = cloudKitRecord[Entry.TitleKey] as? String,
            let bodyText = cloudKitRecord[Entry.BodyTextKey] as? String,
            let ckRecordID = cloudKitRecord[Entry.CKRecordIDKey] as? CKRecordID else { return nil }
        
        self.title = title
        self.bodyText = bodyText
        self.ckRecordID = ckRecordID
    }
    
}

// MARK: - Entry Equatable Conformance
extension Entry: Equatable {
    
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.bodyText == rhs.bodyText && rhs.ckRecordID == lhs.ckRecordID
    }
    
}

// MARK: - CKRecord Extension
extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: Entry.TypeKey, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: Entry.TitleKey)
        self.setValue(entry.bodyText, forKey: Entry.BodyTextKey)
        self.setValue(entry.ckRecordID, forKey: Entry.CKRecordIDKey)
    }
    
}
