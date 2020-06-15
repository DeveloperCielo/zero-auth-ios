//
//  ErrorResponse.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class ErrorResponse: NSObject, Codable {
    var code: String?
    var message: String?
    
    init(code: String?, message: String?) {
        self.code = code
        self.message = message
    }
}
