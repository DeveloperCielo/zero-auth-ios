//
//  CardOnFile.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class CardOnFile: NSObject, Codable {
    var usage: Usage?
    var reason: Reason?
}
