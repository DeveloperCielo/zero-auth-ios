//
//  ZeroAuthRequest.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 25/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class ZeroAuthRequest: NSObject, Codable {
    var cardType: CardType?
    var cardNumber: String?
    var holder: String?
    var expirationDate: String?
    var securityCode: String?
    var saveCard: Bool?
    var brand: String?
    var cardOnFile: CardOnFile?
    var cardToken: String?
}
