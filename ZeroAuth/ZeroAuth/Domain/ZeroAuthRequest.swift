//
//  ZeroAuthRequest.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 25/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public class ZeroAuthRequest: NSObject, Codable {
    public var cardType: CardType?
    public var cardNumber: String?
    public var holder: String?
    public var expirationDate: String?
    public var securityCode: String?
    public var saveCard: Bool?
    public var brand: String?
    public var cardOnFile: CardOnFile?
    public var cardToken: String?
}
