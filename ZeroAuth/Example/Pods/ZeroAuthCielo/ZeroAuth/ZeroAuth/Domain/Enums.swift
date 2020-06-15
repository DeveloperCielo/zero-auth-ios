//
//  Enums.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 23/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc public enum CardType: Int, Codable {
    case creditCard
    case debitCard
}

@objc public enum Usage: Int, Codable {
    case first
    case used
}

@objc public enum Reason: Int, Codable {
    case recurring
    case unscheduled
    case installments
}

@objc public enum Environment: Int {
    case production
    case sandbox
}
