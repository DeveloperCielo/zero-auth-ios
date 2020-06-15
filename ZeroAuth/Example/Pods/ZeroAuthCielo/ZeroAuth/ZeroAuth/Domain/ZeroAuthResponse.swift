//
//  ZeroAuthResponse.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class ZeroAuthResponse: NSObject, Codable {
    var valid: Bool
    var returnCode: String
    var returnMessage: String
    var issuerTransactionId: String
    
    init(valid: Bool, returnCode: String, returnMessage: String, issuerTransactionId: String) {
        self.valid = valid
        self.returnCode = returnCode
        self.returnMessage = returnMessage
        self.issuerTransactionId = issuerTransactionId
    }
}
