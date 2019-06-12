//
//  UseCasesArtist.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation
import PromiseKit
import SDOSAlamofire
import Alamofire

/*
 Dependency register JSON
 
 {
    "dependencyName": "UseCaseArtistSearch",
    "className": "UseCaseArtist.Search"
 }
 */

//MARK: - Definition
protocol UseCaseArtistSearch: BaseUseCaseProtocol {
    func execute(term: String) -> Promise<[ArtistBO]>
}

//MARK: - Implementation
struct UseCaseArtist {
    class Search: UseCaseArtistSearch {
        private lazy var repository: ArtistRepositoryActions = {
            return Dependency.injector.resolveArtistRepositoryActions()
        }()
        var request: Request?
        
        func execute(term: String) -> Promise<[ArtistBO]> {
            request?.cancel()
            return firstly { [weak self] () -> Promise<[ArtistBO]> in
                guard let self = self else { throw PMKError.cancelled }
                let requestValue = repository.loadSearch(term: term)
                self.request = requestValue.request
                return requestValue.value
            }
        }
    }
}
