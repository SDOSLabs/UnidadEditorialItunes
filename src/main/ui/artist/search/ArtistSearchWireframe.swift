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
    //func navigateToView(from navigationController: UINavigationController)
}

class ArtistSearchWireframe: BaseWireframe {
    
}

extension ArtistSearchWireframe: ArtistSearchWireframeActions {
    /*
    func navigateToView(from navigationController: UINavigationController) {
        navigationController.pushViewController(Dependency.injector.<#resolveViewController#>, animated: true)
    }
    */
}
