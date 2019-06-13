//
//  ArtistRepository.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation
import SDOSVIPER
import PromiseKit
import SDOSAlamofire
import Alamofire
import SwifterSwift
import Reachability

/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistRepositoryActions",
    "className": "ArtistRepository"
 }
 */

protocol ArtistRepositoryActions: BaseRepositoryActions {
    func loadSearch(term: String) -> RequestValue<Promise<[ArtistBO]>>
}

class ArtistRepository: BaseRepository {
    private lazy var session = GenericSession()
}

extension ArtistRepository: ArtistRepositoryActions {
    func loadSearch(term: String) -> RequestValue<Promise<[ArtistBO]>> {
        do {
            try isConnected()
        } catch {
            let promise = Promise<[ArtistBO]> { seal in
                seal.reject(error)
            }
            return RequestValue(request: nil, value: promise)
        }
        
        let params: [String] = [
            Constants.ws.paramKey.term + "=" + term.urlEncoded,
            Constants.ws.paramKey.attribute + "=" + Constants.ws.paramValue.attributeArtist,
            Constants.ws.paramKey.entity + "=" + Constants.ws.paramValue.entityArtist
        ]
        
        let url = Environment.urlBase + Constants.ws.search + "?" + params.joined(separator: "&")
        let responseSerializer = SDOSJSONResponseSerializer<[ArtistDTO], ErrorDTO>(jsonResponseRootKey: "results")
        let request = session.request(url, method: .get, parameters: nil)
        
        let promise = Promise<[ArtistDTO]> { seal in
            request.validate().responseSDOSDecodable(responseSerializer: responseSerializer) {
                (dataResponse: DataResponse<[ArtistDTO]>) in
                switch dataResponse.result {
                case .success(let items):
                    seal.fulfill(items)
                case .failure(let error):
                    seal.reject(error)
                }
            }
            }.map { items -> [ArtistBO] in
                return items.compactMap{ $0.toBO() }
        }
        
        return RequestValue(request: request, value: promise)
    }
}
