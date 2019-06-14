//
//  ArtistRepository.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation
import SDOSVIPER
import PromiseKit
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
    private lazy var session = WebServiceSession.init()
}

extension ArtistRepository: ArtistRepositoryActions {
    func loadSearch(term: String) -> RequestValue<Promise<[ArtistBO]>> {
        let params: [String] = [
            Constants.ws.paramKey.term + "=" + term.urlEncoded,
            Constants.ws.paramKey.attribute + "=" + Constants.ws.paramValue.attributeArtist,
            Constants.ws.paramKey.entity + "=" + Constants.ws.paramValue.entityArtist
        ]
        
        let url = Environment.urlBase + Constants.ws.search + "?" + params.joined(separator: "&")
        var request: URLSessionTask?
        let promise: Promise<[ArtistBO]>
        promise = Promise<[ArtistDTO]> { seal in
            request = session.call(with: url, type: ResultDTO<ArtistDTO>.self) { result in
                switch result {
                case .success(let success):
                    seal.fulfill(success.results)
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
