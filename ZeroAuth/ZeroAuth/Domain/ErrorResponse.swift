//
//  ErrorResponse.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class ErrorResponse: NSObject, Codable {
    public var Code: String?
    public var Message: String?
    
    public init(code: String?, message: String?) {
        self.Code = code
        self.Message = message
    }
}
