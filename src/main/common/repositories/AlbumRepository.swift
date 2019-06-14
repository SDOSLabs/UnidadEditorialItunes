//
//  AlbumRepository.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation
import SDOSVIPER
import PromiseKit

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
    private lazy var session = WebServiceSession.init()
}

extension AlbumRepository: AlbumRepositoryActions {
    func load(id: Int) -> RequestValue<Promise<[AlbumBO]>> {
        let params: [String] = [
            Constants.ws.paramKey.id + "=" + String(id),
            Constants.ws.paramKey.attribute + "=" + Constants.ws.paramValue.attributeAlbum,
            Constants.ws.paramKey.entity + "=" + Constants.ws.paramValue.entityAlbum,
            Constants.ws.paramKey.sort + "=" + Constants.ws.paramValue.sortRecent
        ]
        
        let url = Environment.urlBase + Constants.ws.lookup + "?" + params.joined(separator: "&")
        
        var request: URLSessionTask?
        let promise: Promise<[AlbumBO]>
        promise = Promise<[AlbumDTO]> { seal in
            request = session.call(with: url, type: ResultDTO<AlbumDTO>.self) { result in
                switch result {
                case .success(let success):
                    seal.fulfill(success.results)
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
