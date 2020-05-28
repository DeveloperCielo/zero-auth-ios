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
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)", "merchantId": merchantId]
        
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request, completionHandler: { (result, _, error) in
            
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
            
            do {
                let decoder = JSONDecoder()
                
                let decodableData = try decoder.decode(ZeroAuthResponse.self, from: data)
                
                debugPrint(decodableData)
                
                DispatchQueue.main.async {
                    completion(decodableData, nil)
                }
            } catch let exception {
                debugPrint("Exception: \(exception)")
                completion(nil, [ErrorResponse(code: nil, message: exception.localizedDescription)])
            }
        })
        
        task.resume()
    }
}
