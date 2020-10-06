//
//  MainViewController.swift
//  Achieve-iOS
//
//  Created by Mohamad on 2020-10-06.
//

import UIKit

class MainViewController: UIViewController {
    
    var userID: String?

    @IBOutlet var mainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = userID {
            
            mainLabel.text = uid
        }
        
        
    }
    



}
