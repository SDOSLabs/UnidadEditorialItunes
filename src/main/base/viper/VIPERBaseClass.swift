//
//  VIPERBaseClass.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSVIPER
import Reachability

@objc class BaseRepository: VIPERGenericObject {
    func isConnected() throws {
        let reachability = Reachability()!
        
        do {
            try reachability.startNotifier()
            if reachability.connection == .none {
                throw WSError.noConnection
            }
        } catch {
            throw error
        }
    }
}

@objc class BaseInteractor : VIPERGenericObject {
    
}

@objc class BasePresenter : VIPERGenericObject {
    
}

@objc class BaseViewController : VIPERGenericViewController {
    
}

@objc class BaseWireframe: VIPERGenericObject {
    
}
