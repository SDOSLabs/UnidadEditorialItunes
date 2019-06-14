//
//  ArtistAlbumsWireframe.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2019.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit

/*
 Dependency register JSON
 
 {
    "dependencyName": "ArtistAlbumsWireframeActions",
    "className": "ArtistAlbumsWireframe"
 }
 */

protocol ArtistAlbumsWireframeActions: BaseWireframeActions {
    //func navigateToView(from navigationController: UINavigationController)
}

class ArtistAlbumsWireframe: BaseWireframe {
    
}

extension ArtistAlbumsWireframe: ArtistAlbumsWireframeActions {
    /*
    func navigateToView(from navigationController: UINavigationController) {
        navigationController.pushViewController(Dependency.injector.<#resolveViewController#>, animated: true)
    }
    */
}
