//
//  ZeroAuthApi.swift
//  ZeroAuth
//
//  Created by Jeferson Nazario on 25/05/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

@objc protocol ZeroAuthApi {
    func validate(token: String, request: ZeroAuthRequest, completion: @escaping (ZeroAuthResponse?, [ErrorResponse]?) -> Void)
}

@objc class ZeroAuthClient: NSObject, ZeroAuthApi {
    private let merchantId: String
    private let environment: Environment
    
    init(merchantId: String, environment: Environment) {
        self.merchantId = merchantId
        self.environment = environment
    }
    
    func validate(token: String, request: ZeroAuthRequest, completion: @escaping (ZeroAuthResponse?, [ErrorResponse]?) -> Void) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        
        var envUrl = "api"
        if environment == .sandbox {
            envUrl = "apisandbox"
        }
        
        guard let url = URL(string: "https://\(envUrl).cieloecommerce.cielo.com.br/1/zeroauth/") else {
            completion(nil, [ErrorResponse(code: nil, message: "Não foi possível conectar ao servidor, verifique os parâmetros e tente novamente.")])
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(token)", "merchantId": merchantId, "Content-Type": "application/json"]
        urlRequest.httpMethod = "POST"
        
        let sdkName = "CieloZeroAuth-iOS"
        
        guard let bundle = Bundle(identifier: "com.jnazario.ZeroAuth") else {
            completion(nil, "Não foi possível obter o número da versão para registro no servidor.")
            return
        }

        guard let buildVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String else {
            completion(nil, "Não foi possível obter o número da versão para registro no servidor.")
            return
        }
        
        urlRequest.addValue("\(sdkName)@\(buildVersion)", forHTTPHeaderField: "x-sdk-version")
        
        guard let postData = try? JSONEncoder().encode(request) else {
            completion(nil, [ErrorResponse(code: "00", message: "The request should have a body")])
            return
        }
        urlRequest.httpBody = postData
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (result, _, error) in
            
            #if DEBUG
            debugPrint("Result:\n\(String(data: result ?? Data(), encoding: .utf8) ?? "sem result")")
            #endif
            
            guard error == nil else {
                completion(nil, [ErrorResponse(code: nil, message: error?.localizedDescription)])
                return
            }
            guard let data = result else {
                completion(nil, [ErrorResponse(code: nil, message: "Erro ao processar operação.")])
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodableData = try decoder.decode(ZeroAuthResponse.self, from: data)
                
                debugPrint(decodableData)
                
                DispatchQueue.main.async {
                    completion(decodableData, nil)
                }
            } catch let exception {
                guard error != nil else {
                    debugPrint("Exception: \(exception)")
                    completion(nil, [ErrorResponse(code: nil, message: exception.localizedDescription)])
                    return
                }
                
                let decodableError = try? decoder.decode([ErrorResponse].self, from: data)
                
                DispatchQueue.main.async {
                    completion(nil, decodableError)
                }
            }
        })
        
        task.resume()
    }
}
