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
    func load(id: Int) -> RequestValue<Promise<[AlbumBO]>>
}

class AlbumRepository: BaseRepository {
    private lazy var session = GenericSession()
}

extension AlbumRepository: AlbumRepositoryActions {
    func load(id: Int) -> RequestValue<Promise<[AlbumBO]>> {
        do {
            try isConnected()
        } catch {
            let promise = Promise<[AlbumBO]> { seal in
                seal.reject(error)
            }
            return RequestValue(request: nil, value: promise)
        }
        
        let params: [String] = [
            Constants.ws.paramKey.id + "=" + String(id),
            Constants.ws.paramKey.attribute + "=" + Constants.ws.paramValue.attributeAlbum,
            Constants.ws.paramKey.entity + "=" + Constants.ws.paramValue.entityAlbum,
            Constants.ws.paramKey.sort + "=" + Constants.ws.paramValue.sortRecent
        ]
        
        let url = Environment.urlBase + Constants.ws.lookup + "?" + params.joined(separator: "&")
        let responseSerializer = SDOSJSONResponseSerializer<[AlbumDTO], ErrorDTO>(jsonResponseRootKey: "results")
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
