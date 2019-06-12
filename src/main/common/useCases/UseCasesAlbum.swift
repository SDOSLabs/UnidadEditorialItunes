//
//  UseCasesAlbum.swift
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
    "dependencyName": "UseCaseAlbum",
    "className": "UseCaseAlbum."
 }
 */

//MARK: - Definition
protocol UseCaseAlbumList: BaseUseCaseProtocol {
    func execute(id: String) -> Promise<[AlbumBO]>
}

//MARK: - Implementation
struct UseCaseAlbum {
    class List: UseCaseAlbumList {
        private lazy var repository: AlbumRepositoryActions = {
            return Dependency.injector.resolveAlbumRepositoryActions()
        }()
        var request: Request?
        
        func execute(id: String) -> Promise<[AlbumBO]> {
            request?.cancel()
            return firstly { [weak self] () -> Promise<[AlbumBO]> in
                guard let self = self else { throw PMKError.cancelled }
                let requestValue = repository.load(id: id)
                self.request = requestValue.request
                return requestValue.value
            }
        }
    }
}
