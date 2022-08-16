//
//  HelpViewController.swift
//  Weather
//
//  Created by Navi on 02/08/22.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Help"
    }
}
