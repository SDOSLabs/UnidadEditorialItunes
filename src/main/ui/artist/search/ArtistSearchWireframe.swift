//
//  ArtistSearchWireframe.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit

/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistSearchWireframeActions",
    "className": "ArtistSearchWireframe"
 }
 */

protocol ArtistSearchWireframeActions: BaseWireframeActions {
    func goToView(from navigationController: UINavigationController, artistBO: ArtistBO)
}

class ArtistSearchWireframe: BaseWireframe {
    
}

extension ArtistSearchWireframe: ArtistSearchWireframeActions {
    func goToView(from navigationController: UINavigationController, artistBO: ArtistBO) {
        navigationController.pushViewController(Dependency.injector.resolveArtistAlbumsViewActions(artistBO: artistBO), animated: true)
    }
}
