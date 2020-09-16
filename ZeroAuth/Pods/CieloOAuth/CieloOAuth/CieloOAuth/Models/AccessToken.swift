//
//  AccessToken.swift
//  CieloOAuth
//
//  Created by Jeferson Nazario on 27/02/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import Foundation

@objc public class AccessToken: NSObject, Decodable {
    public var token: String
    var expiresIn: String
    var issuedAt: Date
    
    init(token: String, expiresIn: String, issuedAt: Date) {
        self.token = token
        self.expiresIn = expiresIn
        self.issuedAt = issuedAt
    }
}
