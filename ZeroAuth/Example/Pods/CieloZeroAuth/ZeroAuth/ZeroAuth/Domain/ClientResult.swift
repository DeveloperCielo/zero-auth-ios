//
//  ClientResult.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

public class ClientResult<T: Codable>: NSObject, Codable {
    var result: T?
    var statusCode: Int?
    var errors: [ErrorResponse]?
}
