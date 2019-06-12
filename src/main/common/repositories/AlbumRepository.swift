//
//  AlbumRepository.swift
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
    "dependencyName": "AlbumRepositoryActions",
    "className": "AlbumRepository"
 }
 */

protocol AlbumRepositoryActions: BaseRepositoryActions {
    func load() -> RequestValue<Promise<[AlbumBO]>>
}

class AlbumRepository: BaseRepository {
    private lazy var session = GenericSession()
}

extension AlbumRepository: AlbumRepositoryActions {
    func load() -> RequestValue<Promise<[AlbumBO]>> {
        let url = "Constants.ws.Album"
        let responseSerializer = SDOSJSONResponseSerializer<[AlbumDTO], ErrorDTO>()
        let request = session.request(url, method: .get, parameters: nil)
        
        let promise = Promise<[AlbumDTO]> { seal in
            request.validate().responseSDOSDecodable(responseSerializer: responseSerializer) {
                (dataResponse: DataResponse<[AlbumDTO]>) in
                switch dataResponse.result {
                case .success(let items):
                    seal.fulfill(items)
                case .failure(let error):
                    seal.reject(error)
                }
            }
            }.map { items -> [AlbumBO] in
                return items.compactMap{ $0.toBO() }
        }
        
        return RequestValue(request: request, value: promise)
    }
}
