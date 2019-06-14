//
//  VIPERGeneric.swift
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

/// Clase base de los objetos que implementan VIPER
@objc open class VIPERGenericObject: NSObject {
    public override init() {
        super.init()
        commonInit()
    }
    
    func commonInit() {

    }
}

/// Clase base de las vistas que implementan VIPER
@objc open class VIPERGenericViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {

    }
}

/// Protocolo base para los Use Cases
public protocol GenericUseCaseProtocol {
    
}

/// Protocolo base para los presenter que implementan VIPER
public protocol GenericPresenterActions {
    
}

/// Protocolo base para los interactor que implementan VIPER
public protocol GenericInteractorActions {
    
}

/// Protocolo base para los datastore que implementan VIPER
public protocol GenericRepositoryActions {
    
}

/// Protocolo base para los wireframe que implementan VIPER
public protocol GenericWireframeActions {
    
}

/// Protocolo base para los ViewControllers que implementan VIPER
public protocol GenericViewActions {
    
}
