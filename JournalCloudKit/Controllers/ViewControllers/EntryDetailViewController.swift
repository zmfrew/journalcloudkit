//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Zachary Frew on 8/6/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    var entry: Entry?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTF.text, !title.isEmpty, title != " ",
            let bodyText = bodyTV.text, !bodyText.isEmpty, title != " " else { return }
        
        EntryController.shared.addEntryWith(title: title, bodyText: bodyText) { (success) in
            if success {
                print("The entry saved to iCloud.")
            } else {
                let alertController = UIAlertController(title: "Oops!", message: "An error occurred saving your entry. Please ensure you are signed into iCloud and try again.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alertController.addAction(dismissAction)
                self.present(alertController, animated: true)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTF.text = ""
        bodyTV.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        self.title = entry.title
        titleTF.text = entry.title
        bodyTV.text = entry.bodyText
    }
    
}
