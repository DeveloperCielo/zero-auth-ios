//
//  ViewController.swift
//  Example
//
//  Created by Jeferson Nazario on 28/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import UIKit
import ZeroAuthCielo

class ViewController: UITableViewController {
    
    var zeroAuth: ZeroAuth!
    
    @IBOutlet weak var holderName: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expirationDate: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var brand: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroAuth = ZeroAuth.instance(merchanId: "", clientId: "", clientSecret: "", environment: .sandbox)
    }

    
    @IBAction func verifyTouched(_ sender: UIButton) {
        let request = ZeroAuthRequest()
        
        
    }
}

