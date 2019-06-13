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
    func execute(id: Int) -> Promise<[AlbumBO]>
}

//MARK: - Implementation
struct UseCaseAlbum {
    class List: UseCaseAlbumList {
        private lazy var repository: AlbumRepositoryActions = {
            return Dependency.injector.resolveAlbumRepositoryActions()
        }()
        var request: Request?
        
        func execute(id: Int) -> Promise<[AlbumBO]> {
//            request?.cancel()
            return Promise<[AlbumBO]> { seal in
                let requestValue = repository.load(id: id)
                self.request = requestValue.request
                
                requestValue.value.done{ albums in
                    let sortedAlbunes = albums.sorted(by: { (a1, a2) -> Bool in
                        let t1 = a1.releaseDate ?? Date.distantPast
                        let t2 = a2.releaseDate ?? Date.distantPast
                        return t1 > t2
                    })
                    seal.fulfill(sortedAlbunes)
                    }.catch{ error in
                        seal.reject(error)
                }
                
            }
        }
    }
}
