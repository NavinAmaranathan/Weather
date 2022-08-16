//
//  SettingsViewController.swift
//  Weather
//
//  Created by Navi on 03/08/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
}
