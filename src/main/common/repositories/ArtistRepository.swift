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

/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistRepositoryActions",
    "className": "ArtistRepository"
 }
 */

protocol ArtistRepositoryActions: BaseRepositoryActions {
    func loadSearch() -> RequestValue<Promise<[ArtistBO]>>
}

class ArtistRepository: BaseRepository {
    private lazy var session = GenericSession()
}

extension ArtistRepository: ArtistRepositoryActions {
    func loadSearch() -> RequestValue<Promise<[ArtistBO]>> {
        let url = "Constants.ws.ArtistSearch"
        let responseSerializer = SDOSJSONResponseSerializer<[ArtistDTO], ErrorDTO>()
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
