//
//  Services.swift
//  UnidadEditorialItunes
//
//  Created by Rafael Fernandez Alvarez on 13/06/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import Reachability

class WebServiceSession {
    private let session: URLSession = URLSession.init(configuration: .default)
    
    func call<Type: Decodable>(with url: String, type: Type.Type, complete: @escaping (Result<Type, Error>) -> Void ) -> URLSessionTask? {
        do {
            try isConnected()
        } catch {
            complete(Result.failure(error))
            return nil
        }
        if let url = URL(string: url) {
            let request = session.dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    complete(Result.failure(WSError.incorrectHTTPStatusCode))
                    return
                }
                if let error = error {
                    complete(Result.failure(error))
                    return
                }
                guard let data = data else {
                    complete(Result.failure(WSError.noContent))
                    return
                }
                
                do{
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(Type.self, from: data)
                    complete(Result.success(responseModel))
                } catch {
                    complete(Result.failure(error))
                }
            }
            request.resume()
            return request
        } else {
            complete(Result.failure(WSError.noUrl))
            return nil
        }
    }
    
    private func isConnected() throws {
        let reachability = Reachability()!
        
        do {
            try reachability.startNotifier()
            if reachability.connection == .none {
                throw WSError.noConnection
            }
        } catch {
            throw error
        }
    }
}

struct RequestValue<ValueType> {
    
    public let request: URLSessionTask?
    public let value: ValueType
    
    public init(request: URLSessionTask?, value: ValueType) {
        self.request = request
        self.value = value
    }
}

