//
//  ZeroAuth.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 28/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import CieloOAuth

@objc public class ZeroAuth: NSObject {
    private var merchantId: String
    private var clientId: String
    private var clientSecret: String
    private var environment: Environment
    
    private var credentialClient: HttpCredentialsClient?
    private let authenticateErrorMessage: String = "Não foi possível autenticar."
    private var zeroAuthClient: ZeroAuthClient
    
    private init(merchantId: String, clientId: String, clientSecret: String, environment: Environment = .production) {
        self.merchantId = merchantId
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.environment = environment
        
        var oAuthEnv = CieloOAuth.Environment.production
        if environment == .sandbox {
            oAuthEnv = CieloOAuth.Environment.sandbox
        }
        
        credentialClient = HttpCredentialsClient(clientId: clientId,
                                                 clientSecret: clientSecret,
                                                 environment: oAuthEnv)
        
        zeroAuthClient = ZeroAuthClient(merchantId: merchantId, environment: environment)
    }
    
    static func instance(merchanId: String, clientId: String, clientSecret: String, environment: Environment = .production) -> ZeroAuth {
        return ZeroAuth(merchantId: merchanId, clientId: clientId, clientSecret: clientSecret, environment: environment)
    }
    
    public func validate(request: ZeroAuthRequest, completion: @escaping (ZeroAuthResponse?, [ErrorResponse]?) -> Void) {
        authenticate {[weak self] (accessToken, error) in
            guard error == nil else {
                completion(nil, [ErrorResponse(code: nil, message: error)])
                return
            }
            
            guard let token = accessToken else {
                completion(nil, [ErrorResponse(code: nil, message: self?.authenticateErrorMessage)])
                return
            }
            
            self?.zeroAuthClient.validate(token: token, request: request, completion: completion)
        }
    }

    private func authenticate(completion: @escaping (String?, String?) -> Void) {
        credentialClient?.getOAuthCredentials {[weak self] (accessToken, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let token = accessToken else {
                completion(nil, self?.authenticateErrorMessage)
                return
            }
            
            completion(token.token, nil)
        }
    }
}
