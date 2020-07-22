//
//  ZeroAuthResponse.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class ZeroAuthResponse: NSObject, Codable {
    var Valid: Bool
    var ReturnCode: String
    var ReturnMessage: String
    var issuerTransactionId: String?
    
    init(valid: Bool, returnCode: String, returnMessage: String, issuerTransactionId: String?) {
        self.Valid = valid
        self.ReturnCode = returnCode
        self.ReturnMessage = returnMessage
        self.issuerTransactionId = issuerTransactionId
    }
}
