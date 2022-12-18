//
//  ConnectionVC.swift
//  Movies
//
//  Created by Amin on 16/12/2022.
//

import UIKit

class ConnectionVC: UIViewController {
    @IBOutlet weak var uiLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiLabel.text  = "No Internet Connection, try to connect again"
    }

}

