//
//  ErrorResponse.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class ErrorResponse: NSObject, Codable {
    public var code: String?
    public var message: String?
    
    public init(code: String?, message: String?) {
        self.code = code
        self.message = message
    }
}
