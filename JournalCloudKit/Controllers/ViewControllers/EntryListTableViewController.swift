//
//  EntryListTableViewController.swift
//  JournalCloudKit
//
//  Created by Zachary Frew on 8/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    // MARK: - Properties
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = EntryController.shared.entries[indexPath.row]
            EntryController.shared.delete(entry: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
