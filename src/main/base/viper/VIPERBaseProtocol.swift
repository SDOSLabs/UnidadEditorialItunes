//
//  VIPERBaseProtocol.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSVIPER

/// Protocolo base para los use cases
protocol BaseUseCaseProtocol: GenericUseCaseProtocol {
    
}

/// Protocolo base para los presenter que implementan VIPER
protocol BasePresenterActions: GenericPresenterActions {
    
}

/// Protocolo base para los interactor que implementan VIPER
protocol BaseInteractorActions: GenericInteractorActions {
    
}

/// Protocolo base para los datastore que implementan VIPER
protocol BaseRepositoryActions: GenericRepositoryActions {
    
}

/// Protocolo base para los wireframe que implementan VIPER
protocol BaseWireframeActions: GenericWireframeActions {
    
}

/// Protocolo base para los ViewControllers que implementan VIPER
protocol BaseViewActions: GenericViewActions {
    
}
