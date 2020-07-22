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
    @IBOutlet weak var textResult: UITextView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var btnVerify: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroAuth = ZeroAuth.instance(merchanId: "A0BE879C-D2C1-486B-BA0A-04B6D4D7028E",
                                     clientId: "2494d738-a82e-496e-8adc-5e0265b5dcec",
                                     clientSecret: "Rqat2ohHS9FQbXwuXKk9Pksm1ICb9N2pvzh7WD6Yarw=",
                                     environment: .sandbox)
    }
    
    @IBAction func verifyTouched(_ sender: UIButton) {
        textResult.text = ""
        
        let request = ZeroAuthRequest()
        request.cardNumber = cardNumber.text
        request.holder = holderName.text
        request.expirationDate = expirationDate.text
        request.securityCode = cvv.text
        request.brand = brand.text
        
        loading.startAnimating()
        btnVerify.setTitle("", for: .normal)
        
        zeroAuth.validate(request: request) {[weak self] (response, errors) in
            DispatchQueue.main.async {
                self?.loading.stopAnimating()
                self?.btnVerify.setTitle("Verify", for: .normal)
                
                guard errors == nil else {
                    errors?.forEach({ (error) in
                        self?.textResult.text += "Erro \(error.Code ?? "-"): \(error.Message ?? "")\n"
                    })
                    return
                }
                
                do {
                    let jsonData = try JSONEncoder().encode(response)
                    let json = String(data: jsonData, encoding: .utf8)
                                        
                    self?.textResult.text = json

                } catch let ex {
                    self?.textResult.text = ex.localizedDescription
                }
                
                self?.tableView.scrollToRow(at: IndexPath(item: 5, section: 0), at: .top, animated: true)
            }
        }
    }
}

